//
//  NSString+SJString.m
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//
// 字符串的扩展
#import "NSString+SJString.h"
#import <CoreText/CoreText.h>
@implementation NSString (SJString)
/** 自动补全 */
NSString * ifNull(NSString *text){
    return text ? kAutoComplete([NSString stringWithFormat:@"%@",text], @"") : @"";
}
/** 自动补全 */
NSString * kAutoComplete(NSString *text, NSString *complete){
    if (text && [text isKindOfClass:[NSString class]]) {
        return text.length > 0 ? text : complete;
    }
    return  complete;
}
/** 字典或数组转换成字符串 */
+(NSString *)stringWithJsonData:(id)data{
    if (!data) {
        return nil;
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
/** 计算单行文字宽度 */
-(CGFloat)widthWithSize:(int)size{
    CGSize theSize;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName];
    theSize = [self sizeWithAttributes:attributes];
    // 向上取整
    return ceil(theSize.width);
}
-(CGFloat)widthWithFont:(UIFont *)font{
    CGSize theSize;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    theSize = [self sizeWithAttributes:attributes];
    // 向上取整
    return ceil(theSize.width);
}
/** 计算指定宽度文字高度 */
-(CGFloat)heightWithWidth:(CGFloat)width size:(int)size{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}
                                         context:nil];
    return ceil(textRect.size.height);
}
/** 计算指定宽度文字高度 */
-(CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    return ceil(textRect.size.height);
}
/** 对字符串进行URL编码 */
-(NSString *)URLEncodedString{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "] invertedSet]];;
}
/** 对字符串进行URL解码 */
-(NSString *)URLDecodedString{
    return [self stringByRemovingPercentEncoding];
}
/** 根据size计算文件大小 */
+(NSString *)stringWithSize:(NSInteger)size{
    if (size < 1024) {
        return [NSString stringWithFormat:@"%ldkB",(long)size];
    }else if (size < 1024*1024){
        return [NSString stringWithFormat:@"%.1fMB",size / 1024.0];
    }else if (size < 1024*1024*1024){
        return [NSString stringWithFormat:@"%.1fGB",size / 1024.0 / 1024.0];
    }else{
        return [NSString stringWithFormat:@"%.1fTB",size / 1024.0 / 1024.0 / 1024.0];
    }
    return nil;
}

/** 时间戳转换时间 */
-(NSString *)stringWithDataFormatter:(nullable NSString *)dateFormatter{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = (dateFormatter) ? dateFormatter : @"yyyy-MM-dd HH:mm";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(self.length == 10) ? [self integerValue] : [self integerValue] / 1000];
    return [formatter stringFromDate:date];
}
/** 时间戳转换成时间(刚刚、几分钟前、几小时前形式) */
-(NSString *)translateDateFormatter:(NSString *)dateFormatter{
    NSTimeInterval timeInterval = (self.length == 10) ? [self integerValue] : [self integerValue] * 1000;
    NSTimeInterval currentTimeInterval = [NSDate date].timeIntervalSince1970;
    NSInteger seconds = currentTimeInterval - timeInterval; // 时间差
    if (seconds < 60) {
        return @"刚刚";
    }else if (seconds < 60 * 60){
        return [NSString stringWithFormat:@"%ld分钟前",seconds / 60];
    }else if (seconds < 60 * 60 * 24){
        return [NSString stringWithFormat:@"%ld小时前",seconds / 60 /60];
    }else{
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = (dateFormatter) ? dateFormatter : @"yyyy-MM-dd HH:mm";
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        return [formatter stringFromDate:date];
    }
    return nil;
}
/** 将当前时间格式化成字符串 */
+(NSString *)stringDateWithFormatter:(nullable NSString *)dateFormatter{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = (dateFormatter) ? dateFormatter : @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:[NSDate date]];
}
/**
 按行数截取字符串
 
 @param lines 要截取的行数
 @param width 字符串宽度
 @return 截取后的字符串
 */
-(NSString *)subStringWithLines:(int)lines width:(CGFloat)width font:(UIFont *)font{
    NSArray *textArray = [self componentsSeparatedByFont:font width:width];
    if (lines <= textArray.count) {
        NSMutableString *mStr = [NSMutableString string];
        for (int i = 0; i < lines; i++) {
            [mStr appendString:textArray[i]];
        }
        return mStr;
    }else{
        // 如果行数不够的话直接返回原字符串
        return self;
    }
    return @"";
}
/**
 将文字按行分割成字符串
 
 @param font 字体
 @param width 字符串宽度
 @return 字符串数组
 */
- (NSArray<NSString *> *)componentsSeparatedByFont:(UIFont *)font width:(CGFloat)width{
    CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, attStr.length)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,width,MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    CFArrayRef linesRef = CTFrameGetLines(frame);
    NSArray *linesArr = (__bridge NSArray *)linesRef;
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in linesArr){
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [self substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return linesArray;
}

/**
 过滤html标签
 
 @param html htmt字符串
 @return 过滤后的文字
 */
+(NSString *)filterHTML:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO){
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
/** 根据<p>标签分隔html字符串 */
-(NSArray<NSString *> *)componentsSeparatedByTapP{
    NSString *string = [NSString stringWithString:self];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSString *text = nil;
    NSMutableArray *array = [NSMutableArray array];
    while (![scanner isAtEnd]) {
        string = [string substringFromIndex:text.length];
        if (string.length == 0) {
            break;
        }
        [scanner scanUpToString:@"<p" intoString:nil];
        [scanner scanUpToString:@"</p>" intoString:&text];
        text = [NSString stringWithFormat:@"%@</p>",text];
        [array addObject:text];
    }
    return array;
}
/** 替换字符串中的特殊符号 */
-(NSString *)encodeURIComponent{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
#pragma clang diagnostic pop
    return encodedString;
}
/** 判断自身是否符合正则 */
-(BOOL)isMatchWithPattern:(NSString *)pattern{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
/** 根据url组装出参数字典 */
-(NSDictionary *)getParams{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSRange range = [self rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        NSString *queryStr = [self substringFromIndex:range.location + 1];
        NSArray *queryArr = [queryStr componentsSeparatedByString:@"&"];
        for (NSString *query in queryArr) {
            NSArray *arr = [query componentsSeparatedByString:@"="];
            if (arr.count == 2) {
                dict[arr[0]] = dict[arr[1]];
                [dict setObject:arr[1] forKey:arr[0]];
            }
        }
    }
    return [dict copy];
}
/** 获取host name(一个url中:到？或/之间的内容) */
-(NSString *)getHostName{
    NSString *url = [self copy];
    NSRange range = [url rangeOfString:@"://"];
    if (range.location != NSNotFound) {
        url = [url substringFromIndex:range.location + 3];
    }else{
        range = [url rangeOfString:@":"];
        if (range.location != NSNotFound) {
            url = [url substringFromIndex:range.location + 1];
        }
    }
    range = [url rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        url = [url substringToIndex:range.location];
    }
    range = [url rangeOfString:@"/"];
    if (range.location != NSNotFound) {
        url = [url substringToIndex:range.location];
    }
    return url;
}
/** 获取协议名(一个url中:前边的内容) */
-(NSString *)getProtocol{
    NSString *url = [self copy];
    NSRange range = [url rangeOfString:@"://"];
    if (range.location != NSNotFound) {
        url = [url substringToIndex:range.location];
    }else{
        range = [url rangeOfString:@":"];
        if (range.location != NSNotFound) {
            url = [url substringToIndex:range.location];
        }else{
            url = @"";
        }
    }
    return url;
}
/** base64编码 */
-(NSString *)base64Encode{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [sData base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}
/** base64解码 */
-(NSString *)base64Dencode{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *dataString = [[NSString alloc]initWithData:sData encoding:NSUTF8StringEncoding];
    return dataString;
}
@end
