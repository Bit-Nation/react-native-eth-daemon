
#import "RNEthDaemon.h"
#import <Geth/Geth.objc.h>
#import <React/RCTConvert.h>

@implementation RNEthDaemon

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(startDaemon,
                 params:(NSDictionary *)config
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    GethNodeConfig *configGeth;
    NSError *error = nil;
    
    configGeth = GethNewNodeConfig();
    [configGeth setEthereumEnabled: [RCTConvert BOOL:config[@"enabledEthereum"]]];
    long networkID = (long)[RCTConvert NSNumber:config[@"networkID"]];
    [configGeth setEthereumNetworkID: networkID];
    NSString *genesis;
    if (networkID == 1) {
        genesis = GethMainnetGenesis();
    } else {
        genesis = GethTestnetGenesis();
    }
    [configGeth setEthereumGenesis: genesis];
    
    GethEnodes *enodes = GethNewEnodes((long)[RCTConvert NSNumber:config[@"enodesNumber"]]);
    enodes = GethFoundationBootnodes();
    
    [configGeth setBootstrapNodes:enodes];
    [configGeth  setMaxPeers: (long)[RCTConvert NSNumber:config[@"maxPeers"]]];
    [configGeth setWhisperEnabled: [RCTConvert BOOL:config[@"enabledWhisper"]]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *rootUrl =[[fileManager
                      URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]
                     lastObject];
    NSURL *testnetFolderName = [rootUrl URLByAppendingPathComponent:@"ethereum/testnet"];
    
    if (![fileManager fileExistsAtPath:testnetFolderName.path])
        [fileManager createDirectoryAtPath:testnetFolderName.path withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSString *networkDir = [rootUrl.path stringByAppendingString:@"/$TMPDIR"];
    node = GethNewNode(networkDir, configGeth, &error);
    GethSetVerbosity(9);
    
    [node start:&error];
    if (error == nil) {
        resolve(@"Node successfully started");
    } else {
        reject(@"node_error", @"Could not start the node", error);
    }
}

RCT_REMAP_METHOD(stopDaemon,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    
    NSError *error = nil;
    [node stop:&error];
    
    if (error == nil) {
        resolve(@"Node successfully stopped");
    } else {
        reject(@"node_error", @"Could not stop the node", error);
    }
}

@end
