
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

#import <Geth/Geth.objc.h>

@interface RNEthDaemon : NSObject <RCTBridgeModule> {
    GethNode *node;
}

@end
