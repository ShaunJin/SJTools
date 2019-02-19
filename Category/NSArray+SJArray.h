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
/** 移动数组中数据，拖动cell排序时使用 */
-(NSArray *)move:(NSInteger)oriIndex to:(NSInteger)toIndex;
@end
