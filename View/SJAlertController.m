//
//  SJAlertController.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJAlertController.h"

@implementation SJAlertController
/** 自定义标题及提示信息的弹窗 */
+(void)alertWithTitle:(NSString *)title message:(NSString *)message{
    [self makeAlertWithTitle:title message:message blockList:nil titleList:@[@"确认"]];
}
/** 温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message{
    [self alertWithTitle:@"温馨提示" message:message];
}
+(void)hintWarmlyWithMessage:(NSString *)message block:(dispatch_block_t)block{
    [self makeAlertWithTitle:@"温馨提示" message:message blockList:@[block] titleList:@[@"确认"]];
}
/** 错误提示 */
+(void)errorWithMessage:(NSString *)message{
    [self alertWithTitle:@"错误" message:message];
}
/** 创建弹窗 */
+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message blockList:(NSArray *)blockList titleList:(NSArray *)titleList{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < titleList.count; i++) {
        NSString *actionTitle = titleList[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (blockList.count > i) {
                if ([self isBlock:blockList[i]]) {
                    dispatch_block_t block = (dispatch_block_t)blockList[i];
                    block();
                }
            }
        }];
        [alertController addAction:action];
    }
    [kRootViewController presentViewController:alertController animated:YES completion:nil];
}
/** 判断是否是block */
+(BOOL)isBlock:(id)pBlock{
    NSString *className = NSStringFromClass([pBlock class]);
    return  [className isEqualToString:@"__NSMallocBlock__"]||
    [className isEqualToString:@"__NSStackBlock__"]||
    [className isEqualToString:@"__NSGlobalBlock__"];
}
@end
