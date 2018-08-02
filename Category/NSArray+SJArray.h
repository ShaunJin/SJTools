//
//  NSArray+SJArray.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//
// 数组的扩展
#import <Foundation/Foundation.h>

@interface NSArray (SJArray)
/** json字符串转换成数组 */
+(NSArray *)arrayWithJsonString:(NSString *)jsonString;
@end
