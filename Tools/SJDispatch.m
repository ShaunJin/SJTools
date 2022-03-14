//
//  SJDispatch.m
//  emerg
//
//  Created by Air on 2022/3/9.
//
// GCD的一些封装
#import "SJDispatch.h"

@implementation SJDispatch
/** 在主线程执行的任务 */
+(void)addActionToMainQueue:(dispatch_block_t)action{
    dispatch_async(dispatch_get_main_queue(), action);
}
/** 在多线程执行的任务 */
+(void)addActionToGlobalQueue:(dispatch_block_t)action{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), action);
}
/** 延时执行的任务 */
+(void)afterDelay:(float)delay action:(dispatch_block_t)action{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), action);
}
@end
