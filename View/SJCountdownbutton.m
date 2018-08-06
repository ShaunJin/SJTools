//
//  SJCountdownbutton.m
//  AutoBooking
//
//  Created by youwan on 2018/8/4.
//  Copyright © 2018年 gzsm. All rights reserved.
//
// 倒计时按钮
#import "SJCountdownbutton.h"
@interface SJCountdownbutton()
@property(nonatomic,strong)NSTimer      *timer;                         // 计时器
@property(nonatomic,assign)int          timeCount;                      // 计数
@end
@implementation SJCountdownbutton
#pragma mark- CustomMethod
-(void)start{
    self.enabled = NO;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTitle) userInfo:nil repeats:YES];
    [self updateTitle]; // 立即执行一次
}
-(void)stop{
    self.enabled = YES;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timeCount = 0;
    [self updateTitle];
}
-(void)updateTitle{
    self.timeCount = self.timeCount - 1;
    if (self.timeCount == 0) {
        [self stop];
    }else{
        if (self.timeBlock) {
            NSString *text = self.timeBlock(self.timeCount);
            [self setTitle:text forState:UIControlStateNormal];
        }
    }
}
#pragma mark- Setter
-(void)setSeconds:(int)seconds{
    _seconds = seconds;
    self.timeCount = seconds + 1;
}
#pragma mark- Getter
#pragma mark- LifeCycle
-(instancetype)init{
    if (self = [super init]) {
        [self updateTitle];
        self.seconds = 60;
    }
    return self;
}
- (void)dealloc{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
