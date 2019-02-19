//
//  YwSyAlertView.h
//  YwSySDK
//
//  Created by youwan on 2018/6/5.
//  Copyright © 2018年 youwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJAlertController : UIAlertController
/** 自定义标题及提示信息的弹窗 */
+(void)alertWithTitle:(NSString *)title message:(NSString *)message;
/** 在指定页面弹出自定义标题及提示信息的弹窗 */
+(void)alertWithTitle:(NSString *)title message:(NSString *)message onViewController:(UIViewController *)viewController;
/** 温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message;
/** 带bolck的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message block:(dispatch_block_t)block;
/** 在指定页面弹出的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message onViewController:(UIViewController *)viewController;
/** 在指定页面弹出的带block的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message block:(dispatch_block_t)block onViewController:(UIViewController *)viewController;
/** 错误提示 */
+(void)errorWithMessage:(NSString *)message;
/** 在指定页面弹出错误提示 */
+(void)errorWithMessage:(NSString *)message onViewController:(UIViewController *)viewController;
/** 创建弹窗 */
+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message blockList:(NSArray *)blockList titleList:(NSArray *)titleList;
/** 在指定页面创建弹窗创建弹窗 */
+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message blockList:(NSArray *)blockList titleList:(NSArray *)titleList onViewController:(UIViewController *)viewController;
@end
