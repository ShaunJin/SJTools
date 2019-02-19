//
//  NSArray+SJArray.m
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//
// 数组的扩展
#import "NSArray+SJArray.h"
#import "NSDictionary+SJDictionary.h"
@implementation NSArray (SJArray)
/** json字符串转换成数组 */
+(NSArray *)arrayWithJsonString:(NSString *)jsonString{
    if (jsonString) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"json解析失败 ： %@",error);
        }else{
            return array;
        }
    }
    return nil;
}
/** 移动数组中数据，拖动cell排序时使用 */
-(NSArray *)move:(NSInteger)oriIndex to:(NSInteger)toIndex{
    NSMutableArray *mArray = [self mutableCopy];
    id object = mArray[oriIndex];
    [mArray removeObject:object];
    [mArray insertObject:object atIndex:toIndex];
    return mArray;
}
@end
