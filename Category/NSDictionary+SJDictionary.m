//
//  NSDictionary+SJDictionary.m
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//
// 字典的扩展
#import "NSDictionary+SJDictionary.h"
#import "NSArray+SJArray.h"
@implementation NSDictionary (SJDictionary)
/** json字符串转换成字典 */
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
