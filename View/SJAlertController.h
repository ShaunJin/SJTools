//
//  SJAlertController.h
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJAlertController : NSObject
/** 自定义标题及提示信息的弹窗 */
+(void)alertWithTitle:(NSString *)title message:(NSString *)message;
/** 温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message;
/** 温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message block:(dispatch_block_t)block;
/** 错误提示 */
+(void)errorWithMessage:(NSString *)message;
/** 创建弹窗 */
+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message blockList:(NSArray *)blockList titleList:(NSArray *)titleList;
@end
