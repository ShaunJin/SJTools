//
//  NSDictionary+SJDictionary.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//
// 字典的扩展
#import <Foundation/Foundation.h>

@interface NSDictionary (SJDictionary)
/** json字符串转换成字典 */
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
