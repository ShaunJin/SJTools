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
+(instancetype)textFieldWithTextColor:(UIColor *)color size:(CGFloat)size placeholder:(NSString *)placeholder{
    UITextField *textField = [UITextField new];
    textField.font = kFontSize(size);
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    textField.textColor = color;
    return textField;
}

@end
