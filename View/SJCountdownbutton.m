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
    self.timeCount = self.seconds + 1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTitle) userInfo:nil repeats:YES];
    [self updateTitle]; // 立即执行一次
}
-(void)stop{
    self.enabled = YES;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self updateTitleWith:0];
}
-(void)updateTitle{
    self.timeCount = self.timeCount - 1;
    if (self.timeCount <= 0) {
        [self stop];
    }else{
        [self updateTitleWith:self.timeCount];
    }
}
-(void)updateTitleWith:(int)timeCount{
    if (self.timeBlock) {
        NSString *text = self.timeBlock(timeCount);
        [self setTitle:text forState:UIControlStateNormal];
    }
}
#pragma mark- Setter
#pragma mark- Getter
#pragma mark- LifeCycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.seconds = 60;
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        self.seconds = 60;
    }
    return self;
}
- (void)dealloc{
    NSLog(@"%@ : dealloc",NSStringFromClass([self class]));
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
