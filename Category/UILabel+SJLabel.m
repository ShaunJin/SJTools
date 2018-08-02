//
//  UILabel+SJLabel.m
//  CommonTools
//
//  Created by ShaJin on 2017/11/29.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#import "UILabel+SJLabel.h"
@implementation UILabel (SJLabel)
+(instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)size{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    if (color) {
        label.textColor = color;
    }
    if (size > 0) {
        label.font = [UIFont systemFontOfSize:size];
    }
    return label;
}
@end
