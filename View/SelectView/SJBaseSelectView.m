//
//  SJBaseSelectView.m
//  AnJian
//
//  Created by Air on 2021/9/24.
//
// 选择页面，从底部弹出，默认高度为300
#import "SJBaseSelectView.h"
@interface SJBaseSelectView()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIButton *confirmButton;
@end
@implementation SJBaseSelectView
#pragma mark- CustomMethod
-(void)initUI{
    self.animationType = kAnimationBottom;
    self.radius = 0.0;
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(14, 14)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.cancelButton.sd_layout.topSpaceToView(self, 0).leftSpaceToView(self, 0).widthIs(100).heightIs(44);
    self.confirmButton.sd_layout.topSpaceToView(self, 0).rightSpaceToView(self, 0).widthIs(100).heightIs(44);
    self.titleLabel.sd_layout.centerYEqualToView(self.cancelButton).leftSpaceToView(self.cancelButton, 20).rightSpaceToView(self.confirmButton, 20).heightIs(20);
}
-(void)confirmAction{
    
}
-(void)cancelAction{
    [self dismiss];
}
#pragma mark- Setter
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}
-(void)setCancelTineColor:(UIColor *)cancelTineColor{
    _cancelTineColor = cancelTineColor;
    [self.cancelButton setTitleColor:cancelTineColor forState:UIControlStateNormal];
}
-(void)setConfirmTintColor:(UIColor *)confirmTintColor{
    _confirmTintColor = confirmTintColor;
    [self.confirmButton setTitleColor:confirmTintColor forState:UIControlStateNormal];
}
-(void)setTitleTintColor:(UIColor *)titleTintColor{
    _titleTintColor = titleTintColor;
    self.titleLabel.textColor = titleTintColor;
}
#pragma mark- Getter
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:0];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:Color(53, 54, 62) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
    }
    return _cancelButton;
}
-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:0];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:Color(68, 156, 255) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirmButton];
    }
    return _confirmButton;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:kFontSize(kRegFont, 16) textColor:Color(53, 54, 62)];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
#pragma mark- LifeCycle
-(instancetype)init{
    CGRect rect = CGRectMake(0, kHeight - 300 - kSafeAreaBottom, kWidth, 300 + kSafeAreaBottom);
    if (self = [super initWithFrame:rect]) {
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
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
