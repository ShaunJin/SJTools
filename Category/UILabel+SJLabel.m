//
//  UILabel+SJLabel.m
//  CommonTools
//
//  Created by ShaJin on 2017/11/29.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#import "UILabel+SJLabel.h"
@implementation UILabel (SJLabel)
-(CGFloat)textWidth{
    return [self.text widthWithFont:self.font];
}
-(void)setTextWidth:(CGFloat)textWidth{
    // do nothing
}
/** 根据text及指定宽度计算高度 */
-(CGFloat)heightWithWidth:(CGFloat)width{
    return [self.text heightWithWidth:width font:self.font];
}
/** 创建label */
+(instancetype)labelWithTextColor:(UIColor *)textColor size:(CGFloat)size{
    return [self labelWithFontName:kMedFont color:textColor size:size];
}

+(instancetype)labelWithFontName:(NSString *)fontName color:(UIColor *)textColor size:(CGFloat)size{
    UILabel *label = [[self alloc] init];
    label.textColor = textColor;
    label.font = [UIFont fontWithName:fontName size:size];
    return label;
}
@end
