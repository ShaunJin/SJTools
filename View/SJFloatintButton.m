//
//  SJFloatintButton.m
//  EMBase
//
//  Created by Air on 2021/4/23.
//
// 悬浮button
#import "SJFloatintButton.h"
@interface SJFloatintButton()
@property(nonatomic,assign)CGPoint startPoint;
@end
@implementation SJFloatintButton
#pragma mark- CustomMethod
-(void)panGesture:(UIPanGestureRecognizer*)gesture{
    CGPoint point = [gesture translationInView:self.superview];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.startPoint = self.center;
    }
    // 确定边界
    CGFloat minX = self.spaceMargin + self.bounds.size.width / 2;
    CGFloat maxX = kWidth - minX;
    CGFloat minY = self.spaceMargin + self.bounds.size.height / 2;
    CGFloat maxY = kHeight - kSafeAreaTop - kSafeAreaBottom - 44 /** 导航栏 */ - minY;
    
    // 计算addButton位置
    CGFloat x = self.startPoint.x + point.x;
    CGFloat y = self.startPoint.y + point.y;
    
    // 将位置带入边界约束
    x = MAX(minX, x);
    x = MIN(maxX, x);
    y = MAX(minY, y);
    y = MIN(maxY, y);
    
    self.center = CGPointMake(x, y);
    
    // 如果结束拖动了将addButton靠边
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateFailed) {
        if (x > kWidth / 2) {
            x = maxX;
        }else{
            x = minX;
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.center = CGPointMake(x, y);
        }];
    }
}
#pragma mark- Setter
#pragma mark- Getter
#pragma mark- LifeCycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
