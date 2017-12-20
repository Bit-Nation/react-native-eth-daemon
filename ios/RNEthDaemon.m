
#import "RNEthDaemon.h"
#import <Geth/Geth.objc.h>

@implementation RNEthDaemon

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(startDaemon) {
    GethNodeConfig *configGeth;
    NSError *error = nil;
    
    configGeth = GethNewNodeConfig();
    [configGeth setEthereumEnabled:true];
    [configGeth setEthereumNetworkID:3];
    
    GethEnodes *enodes = GethNewEnodes(16);
    enodes = GethFoundationBootnodes();
    
    [configGeth setBootstrapNodes:enodes];
    NSString *genesis = GethTestnetGenesis();
    [configGeth setEthereumGenesis: genesis];
    [configGeth  setMaxPeers: 25];
    [configGeth setWhisperEnabled: NO];
    
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
}

RCT_EXPORT_METHOD(stopDaemon){
    NSError *error = nil;
    [node stop:&error];
}

@end
  
