//
//  SJCountdownbutton.h
//  AutoBooking
//
//  Created by youwan on 2018/8/4.
//  Copyright © 2018年 gzsm. All rights reserved.
//
// 倒计时按钮
#import <UIKit/UIKit.h>

@interface SJCountdownbutton : UIButton
/** 倒计时时间,单位秒，默认60秒 */
@property(nonatomic,assign)int seconds;
/** 时间跳动的block,根据剩余秒数返回button的标题 */
@property(nonatomic,copy)NSString *(^timeBlock)(int leftSeconds);
/** 开始计时 */
-(void)start;
/** 停止计时 */
-(void)stop;
@end
