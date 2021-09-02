//
//  SJBaseAlertView.m
//  CommonTools
//
//  Created by ShaJin on 2017/12/9.
//  Copyright © 2017年 ShaJin. All rights reserved.
//
// 弹出视图的基类
#import "SJBaseAlertView.h"

@interface SJBaseAlertView()
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)NSValue *oriFrame;
@end
@implementation SJBaseAlertView
#pragma mark- CustomMethod
- (void)setDefaultSettings{
    self.dismissOnTouchOutside = YES;
    self.cornerRadius = 5.0;
    self.isShowShadow = YES;
    // 背景色
    self.backgroundColor = [UIColor whiteColor];
    self.duration = 0.25;
}
-(void)show{
    if (!self.oriFrame) {
        self.oriFrame = [NSValue valueWithCGRect:self.frame];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    switch (_animationType) {
        case kAnimationBottom:{
            self.top = kHeight;
            [UIView animateWithDuration: self.duration animations:^{
                self.frame = [self.oriFrame CGRectValue];
                self.alpha = 1;
                self.backgroundView.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        }break;
        default:{
            self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
            self.alpha = 0;
            [UIView animateWithDuration: self.duration animations:^{
                self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
                self.alpha = 1;
                self.backgroundView.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        }break;
    }
}
- (void)dismiss{
    switch (_animationType) {
        case kAnimationBottom:{
            [UIView animateWithDuration: self.duration animations:^{
                self.top = kHeight;
                self.backgroundView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self.backgroundView removeFromSuperview];
            }];
        }break;
        default:{
            [UIView animateWithDuration: self.duration animations:^{
                self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
                self.alpha = 0;
                self.backgroundView.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self.backgroundView removeFromSuperview];
            }];
        }break;
    }
}
-(void)touchOutSide{
    if (_dismissOnTouchOutside) {
        [self dismiss];
    }
}
#pragma mark- Setter
-(void)setCornerRadius:(CGFloat)cornerRadius{
    if (cornerRadius >= 0) {
        self.radius = cornerRadius;
        _cornerRadius = cornerRadius;
    }
}
- (void)setIsShowShadow:(BOOL)isShowShadow{
    _isShowShadow = isShowShadow;
    self.layer.shadowOpacity = isShowShadow ? 0.5 : 0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = isShowShadow ? 2.0 : 0;
}
#pragma mark- Getter
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _backgroundView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchOutSide)];
        [_backgroundView addGestureRecognizer: tap];
    }
    return _backgroundView;
}
#pragma mark- 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setDefaultSettings];
    }
    return self;
}

@end
