#import <UIKit/UIKit.h>
#import "RCTBridgeModule.h"
#import "RCTUtils.h"

@interface RCTICloudToken : NSObject <RCTBridgeModule>

@end

@implementation RCTICloudToken

RCT_EXPORT_MODULE();

#pragma mark - get iCloud token
RCT_REMAP_METHOD(getToken,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
  id token = [[NSFileManager defaultManager] ubiquityIdentityToken];

  if (token == nil) {
    NSString *code;
    NSString *message = @"Could not get token";
    NSError *error;
    reject(code, message, error);
  } else {
    // NSData to NSString
    NSString *rawToken = [NSString stringWithFormat:@"%@", token];
    // Remove surrounding brackets
    NSCharacterSet *charsToRemove = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    // Remove spaces
    NSString *tokenStr = [rawToken stringByTrimmingCharactersInSet:charsToRemove];
    NSString *cleanToken = [[tokenStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
                                                  componentsJoinedByString:@""];

    resolve(cleanToken);
  }
}

@end
