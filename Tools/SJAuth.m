//
//  SJAuth.m
//  emerg
//
//  Created by Air on 2022/3/1.
//

#import "SJAuth.h"
#import <LocalAuthentication/LocalAuthentication.h>
@implementation SJAuth
+(SJAuthType)authType{
    LAContext *context = [LAContext new];
    NSError *error = nil;
    LAPolicy policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    if ([context canEvaluatePolicy:policy error:&error]) {
        if (@available(iOS 11.0, *)) {
            if (context.biometryType == LABiometryTypeTouchID) {
                return SJAuthTypeTouchID;
            }else if (context.biometryType == LABiometryTypeFaceID){
                return SJAuthTypeFaceID;
            }
        }else{
            return (kSafeAreaBottom == 0) ? SJAuthTypeTouchID : SJAuthTypeFaceID;
        }
    }
    return SJAuthTypeNone;
}
+(void)authWithCanPassword:(BOOL)canPassword successBlock:(void(^)(void))successBlock failureBlock:(void(^)(NSError *error))failureBlock passwordBlock:(nullable void(^)(void))passwordBlock{
    LAContext *context = [LAContext new];
    NSError *error = nil;
    if (!canPassword) {
        context.localizedFallbackTitle = @"";
    }
    LAPolicy policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    if ([context canEvaluatePolicy:policy error:&error]) {
        // 用是否有底部safearea来判断是指纹识别还是面容识别
        NSString *tips = (kSafeAreaBottom == 0) ? @"触控ID" : @"面容ID";
        [context evaluatePolicy:policy localizedReason:tips reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                // 认证成功
                if (successBlock) {
                    successBlock();
                }
            }else{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if (failureBlock) {
                        failureBlock(error);
                    }
                }];
                NSString *msg = @"认证失败";
                switch (error.code){
                        // Authentication was not successful, because user failed to provide valid credentials
                    case LAErrorAuthenticationFailed:{
                        NSLog(@"授权失败"); // -1 连续三次指纹识别错误
                        msg = @"授权失败";
                    }break;
                        // Authentication was canceled by user (e.g. tapped Cancel button)
                    case LAErrorUserCancel:{
                        NSLog(@"用户取消验证Touch ID"); // -2 在TouchID对话框中点击了取消按钮
                        msg = @"用户取消验证";
                    }break;
                        // Authentication was canceled, because the user tapped the fallback button (Enter Password)
                    case LAErrorUserFallback:{
                        NSLog(@"用户选择输入密码，切换主线程处理"); // -3 在TouchID对话框中点击了输入密码按钮
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            if (passwordBlock) {
                                passwordBlock();
                            }
                        }];
                    }break;
                        // Authentication was canceled by system (e.g. another application went to foreground)
                    case LAErrorSystemCancel:{
                        NSLog(@"取消授权，如其他应用切入，用户自主"); // -4 TouchID对话框被系统取消，例如按下Home或者电源键
                    }break;
                        // Authentication could not start, because passcode is not set on the device.
                    case LAErrorPasscodeNotSet:{
                        NSLog(@"设备系统未设置密码"); // -5
                    }break;
                    default:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [SJAlertController hintWarmlyWithMessage:msg];
                }];
            }
        }];
    }else{
        NSLog(@"不支持指纹/面容识别");
    }
}
@end
