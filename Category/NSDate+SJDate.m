//
//  NSDate+SJDate.m
//  renejin
//
//  Created by ShaJin on 2019/2/25.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import "NSDate+SJDate.h"

@implementation NSDate (SJDate)
/** 根据时间戳获取字符串 */
+(NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval useDateFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    if (formatter) {
        dateFormatter.dateFormat = formatter;
    }else{
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [dateFormatter stringFromDate:date];
}
/** 获取当前时间 */
+(NSString *)currentTimeStringWithDateFormatter:(NSString *)formatter{
    return [self stringWithTimeInterval:[NSDate date].timeIntervalSince1970 useDateFormatter:formatter];
}
/** 将字符串转换成NSDate(需提供格式) */
+(NSDate *)dateWithString:(NSString *)dateStr formatter:(nullable NSString *)formatterStr{
    NSSet *set = [NSSet setWithObjects:ifNull(formatterStr),@"yyyy-MM-dd HH:mm",@"yyyy-MM-dd HH:mm:ss",@"yyyy-MM-dd", nil];
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSDate *date = nil;
    for (NSString *dateFormat in [set allObjects]) {
        [formatter setDateFormat:dateFormat];
        date = [formatter dateFromString:dateStr];
        if (date) {
            break;
        }
    }
    return date;
}
/** 将NSDate转换成字符串时间(刚刚、几分钟前、几小时前形式) */
-(NSString *)toString{
    NSTimeInterval timeInterval = self.timeIntervalSince1970;;
    NSTimeInterval currentTimeInterval = [NSDate date].timeIntervalSince1970;
    NSInteger seconds = currentTimeInterval - timeInterval; // 时间差
    if (seconds < 60) {
        return @"刚刚";
    }else if (seconds < 60 * 60){
        return [NSString stringWithFormat:@"%ld分钟前",seconds / 60];
    }else{
        NSDateFormatter *formatter = [NSDateFormatter new];
        // 判断是否是同一年的时间
        [formatter setDateFormat:@"yyyy"];
        NSString *year1 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
        NSString *year2 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:currentTimeInterval]];
        if ([year1 isEqualToString:year2]) {
            // 判断是不是同一天
            [formatter setDateFormat:@"MM-dd"];
            NSString *day1 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
            NSString *day2 = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:currentTimeInterval]];
            if ([day1 isEqualToString:day2]) {
                [formatter setDateFormat:@"HH:mm"];
            }
        }else{
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }
        return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return nil;
}
/** 将NSDate转换成指定格式的字符串 */
-(NSString *)toStringWithFormat:(NSString *)formatterStr{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:formatterStr];
    return [formatter stringFromDate:self];
}
@end
