//
//  NSDate+SJDate.h
//  renejin
//
//  Created by ShaJin on 2019/2/25.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (SJDate)
/** 获取当前时间 */
+(NSString *)currentTimeStringWithDateFormatter:(nullable NSString *)formatter;
/** 根据时间戳获取字符串 */
+(NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval useDateFormatter:(nullable NSString *)formatter;
/** 将字符串转换成NSDate(需提供格式) */
+(NSDate *)dateWithString:(NSString *)dateStr formatter:(nullable NSString *)formatterStr;
/** 将NSDate转换成字符串时间(刚刚、几分钟前、几小时前形式) */
-(NSString *)toString;
/** 将NSDate转换成指定格式的字符串 */
-(NSString *)toStringWithFormat:(NSString *)formatterStr;
@end

NS_ASSUME_NONNULL_END
