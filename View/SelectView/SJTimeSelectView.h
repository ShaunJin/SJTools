//
//  SJTimeSelectView.h
//  AnJian
//
//  Created by Air on 2021/9/24.
//
// 时间选择页面，精确到分
#import "SJBaseSelectView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SJTimeSelectView : SJBaseSelectView
/**
 可选时间的最小值和最大值
 默认为0（1970-01-01 08:00）到6311433600（2170-01-01 08:00:00）
 只能设置这个区间内的数值，并且最小值不能大于最大值
 */
@property(nonatomic,assign)double startTimestamp;
@property(nonatomic,assign)double endTimestamp;

@property(nonatomic,copy)void (^selectBlock)(double timestamp);
+(instancetype)selectViewWithTimestamp:(double)timestamp;
@end

NS_ASSUME_NONNULL_END
