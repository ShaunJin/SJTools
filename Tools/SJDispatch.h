//
//  SJDispatch.h
//  emerg
//
//  Created by Air on 2022/3/9.
//
// GCD的一些封装
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJDispatch : NSObject
/** 在主线程执行的任务 */
+(void)addActionToMainQueue:(dispatch_block_t)action;
/** 在多线程执行的任务 */
+(void)addActionToGlobalQueue:(dispatch_block_t)action;
/** 延时执行的任务 */
+(void)afterDelay:(float)delay action:(dispatch_block_t)action;
@end

NS_ASSUME_NONNULL_END
