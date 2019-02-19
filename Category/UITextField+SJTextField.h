//
//  UITextField+SJTextField.h
//  AutoBooking
//
//  Created by youwan on 2018/8/2.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SJTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end
@interface UITextField (SJTextField)

@property (weak, nonatomic) id<SJTextFieldDelegate> delegate;
/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const SJTextFieldDidDeleteBackwardNotification;
/** 创建textfield */
+(instancetype)textFieldWithTextColor:(UIColor *)color size:(CGFloat)size placeholder:(NSString *)placeholder;
@end
