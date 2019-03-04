#import "HelloPlugin.h"
#import <Razorpay/Razorpay-Swift.h>


@interface HelloPlugin () <RazorpayPaymentCompletionProtocol> {
  Razorpay *razorpay;
  FlutterResult _result;
    
}

@end

@implementation HelloPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"hello"
            binaryMessenger:[registrar messenger]];
  HelloPlugin* instance = [[HelloPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
   
  _result = result;
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
      
    result([@"iOS 9" stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"RazorPayForm" isEqualToString:call.method]){
          NSDictionary* argsMap = call.arguments;

      razorpay = [Razorpay initWithKey:@"rzp_live_zPHQ09xGSyS49d" andDelegate:self];
      
      
      NSDictionary *options = @{
                                @"amount" : (NSNumber*)argsMap[@"amount"],
                                @"currency" : @"INR",
                                @"description" : (NSString*)argsMap[@"description"],
                                @"name" : (NSString*)argsMap[@"name"],
                                @"external" : @{@"wallets" : @[ @"paytm" ]},
                                @"prefill" :
                                        @{@"email" : (NSString*)argsMap[@"email"] },
                                @"theme" : @{@"color" : @"#FF6E0D"}
                                };
      
      [razorpay open:options];
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}
- (void)onPaymentSuccess:(nonnull NSString*)payment_id {
    
    _result(@{@"code": @"1",
              @"message" : payment_id,
              @"status" : @"success",
             
              });

}

- (void)onPaymentError:(int)code description:(nonnull NSString *)str {
    _result(@{@"code": @"0",
              @"message": @"payment cancelled by user",
              @"status" : @"faild",
              
              });

}
@end



