//
//  SJAppDelegate.m
//  SJTools
//
//  Created by Air on 2021/10/25.
//

#import "SJAppDelegate.h"
static SJAppDelegate *app;
@interface SJAppDelegate()

@end
@implementation SJAppDelegate
#pragma mark- StaticMethod
+(instancetype)getApp{
    return app;
}
+(void)openView:(NSString *)url{
    if ([url isKindOfClass:[NSString class]]) {
        if ([url hasPrefix:@"push"] || [url hasPrefix:@"present"]) {
            NSString *className = [url getHostName];
            NSDictionary *params = [url getParams];
            Class class = NSClassFromString(className);
            id obj = [class new];
            if ([obj isKindOfClass:[UIViewController class]]) {
                UIViewController *vc = (UIViewController *)obj;
                for (NSString *key in [params allKeys]) {
                    if ([key isEqualToString:@"title"]) {
                        vc.title = params[key];
                    }else{
                        [vc setValue:params[key] forKey:key];
                    }
                }
                if ([url hasPrefix:@"push"]) {
                    [[UINavigationController getCurrentNavigationController] pushViewController:vc animated:YES];
                }else if ([url hasPrefix:@"present"]){
                    [[UIViewController topViewController] presentViewController:vc animated:YES completion:nil];
                }
            } 
        }else if ([url hasPrefix:@"http"]){
            NSLog(@"open : %@",url);
        }
    }else{
        [SJAlertController errorWithMessage:[NSString stringWithFormat:@"不支持的url：%@",url]];
    }
}
#pragma mark- CustomMethod
#pragma mark- Setter
#pragma mark- Getter
#pragma mark- LifeCycle
-(instancetype)init{
    if (self = [super init]) {
        app = self;
    }
    return self;
}
@end
