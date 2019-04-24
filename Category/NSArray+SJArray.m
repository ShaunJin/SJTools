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
//#ifdef DEBUG
//    //打印到控制台时会调用该方法
//- (NSString *)descriptionWithLocale:(id)locale{
//    return self.debugDescription;
//}
//    //有些时候不走上面的方法，而是走这个方法
//- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
//    return self.debugDescription;
//}
//    //用po打印调试信息时会调用该方法
//- (NSString *)debugDescription{
//    NSError *error = nil;
//        //字典转成json
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted  error:&error];
//        //如果报错了就按原先的格式输出
//    if (error) {
//        return [super debugDescription];
//    }
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    return jsonString;
//}
//#endif
@end
