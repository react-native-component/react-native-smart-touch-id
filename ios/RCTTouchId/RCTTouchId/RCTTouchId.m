#import <React/RCTTouchId.h>
#import <React/RCTUtils.h>
#import <LocalAuthentication/LocalAuthentication.h>

@implementation RCTTouchId

RCT_EXPORT_MODULE(TouchId);

RCT_EXPORT_METHOD(verify:(NSString *)reason
                  title:(NSString *)title
                  callback:(RCTResponseSenderBlock)callback)
{
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = title;
    NSError *error;
    // TouchID is supported
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:reason
                          reply:^(BOOL success, NSError *error) {
                              //Authenticate failed
                              if(error) {
                                  callback(@[RCTMakeError([NSString stringWithFormat:@"%d", error.code], nil, nil)]);
                              }
                              else {
                                  callback(@[[NSNull null]]);
                              }
                          }];
    }
    // TouchID is not supported
    else {
        callback(@[RCTMakeError(@"", nil, nil)]);
    }
}

RCT_EXPORT_METHOD(isSupported: (RCTResponseSenderBlock)callback)
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    // TouchID is supported
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        callback(@[[NSNull null]]);
        // TouchID is not supported
    }
    else {
        callback(@[RCTMakeError(@"", nil, nil)]);
        return;
    }
}

@end
