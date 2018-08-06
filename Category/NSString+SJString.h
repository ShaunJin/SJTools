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
@interface NSString (SJString)
/** 字符串不存在替换成@“” */
NSString * ifNull(NSString *text);
/** 根据<p>标签分隔html字符串 */
-(NSArray<NSString *> *)componentsSeparatedByTapP;
/** 字典或数组转换成字符串 */
+(NSString *)stringWithJsonData:(id)data;
/** 计算单行文字宽度 */
-(CGFloat)widthWithSize:(int)size;
/** 计算指定宽度文字高度 */
-(CGFloat)heightWithWidth:(CGFloat)width size:(int)size;
/** 对字符串进行URL编码 */
-(NSString *)URLEncodedString;
/** 对字符串进行URL解码 */
-(NSString *)URLDecodedString;
/** 根据size计算文件大小 */
+(NSString *)stringWithSize:(NSInteger)size;
/** 根据时间戳获取字符串 */
+(NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval useDateFormatter:(NSDateFormatter *)dateFormatter;
/** 时间戳转换时间 */
-(NSString *)stringWithDataFormatter:(NSString *)dateFormatter;
/** 时间戳转换成时间(刚刚、几分钟前、几小时前形式) */
-(NSString *)translateDateFormatter:(NSString *)dateFormatter;
/** 替换字符串中的特殊符号 */
-(NSString *)encodeURIComponent;
/** 判定是否是手机号 */
-(BOOL)isPhoneNumber;
/** 身份证号验证(粗略验证，只判断格式是否正确) */
-(BOOL)isIdNmuber;
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
@end
