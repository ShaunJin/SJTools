//
//  UILabel+SJLabel.m
//  CommonTools
//
//  Created by ShaJin on 2017/11/29.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#import "UILabel+SJLabel.h"
@implementation UILabel (SJLabel)
/** 创建label */
+(instancetype)labelWithTextColor:(UIColor *)textColor size:(CGFloat)size{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}
@end
