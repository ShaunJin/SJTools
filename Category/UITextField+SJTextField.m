//
//  UITextField+SJTextField.m
//  AutoBooking
//
//  Created by youwan on 2018/8/2.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "UITextField+SJTextField.h"

@implementation UITextField (SJTextField)
/** 创建textfield */
+(instancetype)textFieldWithTextColor:(UIColor *)color size:(CGFloat)size placeholder:(NSString *)placeholder{
    UITextField *textField = [UITextField new];
    textField.font = kFontSize(size);
    textField.placeholder = placeholder;
    textField.textColor = color;
    return textField;
}
@end
