//
//  SJTitleLabel.m
//  emerg
//
//  Created by Air on 2022/2/23.
//

#import "SJTitleLabel.h"

@implementation SJTitleLabel
#pragma mark- CustomMethod
-(void)refresh{
    NSString *text = [NSString stringWithFormat:@"%@%@",self.title,self.content ? self.content : @""];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    if (self.title && self.titleColor) {
        NSRange range = [text rangeOfString:self.title];
        [attr addAttributes:@{NSForegroundColorAttributeName:self.titleColor} range:range];
    }
    if (self.content && self.contentColor) {
        NSRange range = [text rangeOfString:self.content];
        [attr addAttributes:@{NSForegroundColorAttributeName:self.contentColor} range:range];
    }
    self.attributedText = attr;
}
#pragma mark- Setter
-(void)setTitle:(NSString *)title{
    _title = title;
    [self refresh];
}
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self refresh];
}
-(void)setContent:(NSString *)content{
    _content = content;
    [self refresh];
}
-(void)setContentColor:(UIColor *)contentColor{
    _contentColor = contentColor;
    [self refresh];
}
#pragma mark- Getter
#pragma mark- LifeCycle
+(instancetype)labelWithFont:(UIFont *)font{
    SJTitleLabel *label = [SJTitleLabel new];
    label.font = font;
    return label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
