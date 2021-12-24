//
//  UITextField+SJTextField.m
//  AutoBooking
//
//  Created by youwan on 2018/8/2.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "UITextField+SJTextField.h"
#import <objc/runtime.h>
NSString * const SJTextFieldDidDeleteBackwardNotification = @"com.shajin.textfield.did.notification";
@implementation UITextField (SJTextField)
+ (void)load {
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(wj_deleteBackward));
    method_exchangeImplementations(method1, method2);
}
- (void)wj_deleteBackward {
    [self wj_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)]){
        id <SJTextFieldDelegate> delegate  = (id<SJTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SJTextFieldDidDeleteBackwardNotification object:self];
}
/** 创建textfield */
+(instancetype)textFieldWithTextColor:(UIColor *)color size:(CGFloat)size placeholder:(nullable NSString *)placeholder{

    return [self textFieldWithTextColor:color size:size placeholder:placeholder placeholderColor:nil];
}
/** 创建textfield */
+(instancetype)textFieldWithTextColor:(UIColor *)color size:(CGFloat)size placeholder:(nullable NSString *)placeholder placeholderColor:(nullable UIColor *)placeholderColor{
    UITextField *textField = [self new];
    textField.font = kFontSize(kRegFont,size);
    if (placeholder && placeholderColor) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    }else if(placeholder){
        textField.placeholder = placeholder;
    }
    textField.textColor = color;
    return textField;
}
+(instancetype)textFieldWithTextColor:(UIColor *)color font:(UIFont *)font placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor{
    UITextField *textField = [self new];
    textField.font = font;
    if (placeholder && placeholderColor) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    }else if(placeholder){
        textField.placeholder = placeholder;
    }
    textField.textColor = color;
    return textField;
}
@end
