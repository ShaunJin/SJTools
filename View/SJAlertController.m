//
//  YwSyAlertView.m
//  YwSySDK
//
//  Created by youwan on 2018/6/5.
//  Copyright © 2018年 youwan. All rights reserved.
//

#import "SJAlertController.h"

@interface SJAlertController ()
@property(nonatomic,strong)NSMutableArray *blockList;
@end

@implementation SJAlertController
/** 自定义标题及提示信息的弹窗 */
+(void)alertWithTitle:(NSString *)title message:(NSString *)message{
    [self makeAlertWithTitle:title message:message blockList:nil titleList:@[@"确定"]];
}
/** 在指定页面弹出自定义标题及提示信息的弹窗 */
+(void)alertWithTitle:(NSString *)title message:(NSString *)message onViewController:(UIViewController *)viewController{
    [self makeAlertWithTitle:title message:message blockList:nil titleList:@[@"确定"] onViewController:viewController];
}
/** 温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message{
    [self alertWithTitle:@"温馨提示" message:message];
}
/** 带bolck的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message block:(dispatch_block_t)block{
    [self makeAlertWithTitle:@"温馨提示" message:message blockList:@[block] titleList:@[@"确定"]];
}
/** 在指定页面弹出的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message onViewController:(UIViewController *)viewController{
    [self alertWithTitle:@"温馨提示" message:message onViewController:viewController];
}
/** 在指定页面弹出的带block的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message block:(dispatch_block_t)block onViewController:(UIViewController *)viewController{
    [self makeAlertWithTitle:@"温馨提示" message:message blockList:@[block] titleList:@[@"确定"] onViewController:viewController];
}
/** 错误提示 */
+(void)errorWithMessage:(NSString *)message{
    [self alertWithTitle:@"错误" message:message];
}
/** 在指定页面弹出错误提示 */
+(void)errorWithMessage:(NSString *)message onViewController:(UIViewController *)viewController{
    [self alertWithTitle:@"错误" message:message onViewController:viewController];
}

/** 创建弹窗 */
+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message blockList:(NSArray *)blockList titleList:(NSArray *)titleList{
    [self makeAlertWithTitle:title message:message blockList:blockList titleList:titleList onViewController:nil];
}
/** 在指定页面创建弹窗创建弹窗 */
+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message blockList:(NSArray *)blockList titleList:(NSArray *)titleList onViewController:(UIViewController *)viewController{
    SJAlertController *alertController = [SJAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < titleList.count; i++) {
        NSString *actionTitle = titleList[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (blockList.count > i) {
                if ([self YwSy_isBlock_YwSy:blockList[i]]) {
                    dispatch_block_t block = (dispatch_block_t)blockList[i];
                    block();
                }
            }
        }];
        [alertController addAction:action];
    }
    if ([viewController isKindOfClass:[UIViewController class]]) {
        [viewController presentViewController:alertController animated:YES completion:nil];
    }else{
        [kRootViewController presentViewController:alertController animated:YES completion:nil];
    }
}
/** 判断是否是block */
+(BOOL)YwSy_isBlock_YwSy:(id)pBlock
{
    NSString *className = NSStringFromClass([pBlock class]);
    return  [className isEqualToString:@"__NSMallocBlock__"]||
    [className isEqualToString:@"__NSStackBlock__"]||
    [className isEqualToString:@"__NSGlobalBlock__"];
}
@end
