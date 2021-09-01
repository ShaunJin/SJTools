//
//  NSString+SJString.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//
// 字符串的扩展
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (SJString)
/** 字符串不存在替换成@“” */
NSString * ifNull(NSString *text);
/** 自动补全 */
NSString * kAutoComplete(NSString *text, NSString *complete);
/** 根据<p>标签分隔html字符串 */
-(NSArray<NSString *> *)componentsSeparatedByTapP;
/** 字典或数组转换成字符串 */
+(NSString *)stringWithJsonData:(id)data;
/** 计算单行文字宽度 */
-(CGFloat)widthWithFont:(UIFont *)font;
/** 计算指定宽度文字高度 */
-(CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font;
/** 对字符串进行URL编码 */
-(NSString *)URLEncodedString;
/** 对字符串进行URL解码 */
-(NSString *)URLDecodedString;
/** 根据size计算文件大小 */
+(NSString *)stringWithSize:(NSInteger)size;
/** 时间戳转换时间 */
-(NSString *)stringWithDataFormatter:(nullable NSString *)dateFormatter;
/** 时间戳转换成时间(刚刚、几分钟前、几小时前形式) */
-(NSString *)translateDateFormatter:(NSString *)dateFormatter;
/** 将当前时间格式化成字符串 */
+(NSString *)stringDateWithFormatter:(nullable NSString *)dateFormatter;
/** 替换字符串中的特殊符号 */
-(NSString *)encodeURIComponent;
/**
 将文字按行分割成字符串
 
 @param font 字体
 @param width 字符串宽度
 @return 字符串数组
 */
- (NSArray<NSString *> *)componentsSeparatedByFont:(UIFont *)font width:(CGFloat)width;
/**
 按行数截取字符串
 
 @param lines 要截取的行数
 @param width 字符串宽度
 @return 截取后的字符串
 */
-(NSString *)subStringWithLines:(int)lines width:(CGFloat)width font:(UIFont *)font;

/**
 过滤html标签
 
 @param html htmt字符串
 @return 过滤后的文字
 */
+(NSString *)filterHTML:(NSString *)html;
/** 根据url组装出参数字典（url中？后边的内容） */
-(NSDictionary *)getParams;
/** 获取host name(一个url中:到？之间的内容) */
-(NSString *)getHostName;
/** 获取协议名(一个url中:前边的内容) */
-(NSString *)getProtocol;
/** 判断自身是否符合正则 ,pattern是正则表达式*/
-(BOOL)isMatchWithPattern:(NSString *)pattern;
@end
NS_ASSUME_NONNULL_END
