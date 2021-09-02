//
//  SJBackTextField.m
//  EMBase
//
//  Created by Air on 2021/4/28.
//
// 自带背景的TextField
#import "SJBackTextField.h"

@implementation SJBackTextField
#pragma mark- CustomMethod
-(void)layoutSubviews{
    [super layoutSubviews];
    [self resetTextFieldFrame];
}
-(void)resetTextFieldFrame{
    CGFloat x = self.backEdgeInsets.left;
    CGFloat y = self.backEdgeInsets.top;
    CGFloat w = self.frame.size.width - self.backEdgeInsets.left - self.backEdgeInsets.right;
    CGFloat h = self.frame.size.height - self.backEdgeInsets.top - self.backEdgeInsets.bottom;
    self.textField.frame = CGRectMake(x, y, w, h);
}
#pragma mark- Setter
-(void)setBackEdgeInsets:(UIEdgeInsets)backEdgeInsets{
    _backEdgeInsets = backEdgeInsets;
    [self resetTextFieldFrame];
}
#pragma mark- Getter
-(UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        [self addSubview:_textField];
    }
    return _textField;
}
#pragma mark- LifeCycle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
