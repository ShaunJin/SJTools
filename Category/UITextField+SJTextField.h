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
- (void)textFieldDidDeleteBackward:(nonnull UITextField *)textField;
@end
@interface UITextField (SJTextField)

@property (weak, nonatomic, nullable) id<SJTextFieldDelegate>  delegate;
/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * _Nullable const SJTextFieldDidDeleteBackwardNotification;
/** 创建textfield */
+(nonnull instancetype)textFieldWithTextColor:(nonnull UIColor *)color size:(CGFloat)size placeholder:(nullable NSString *)placeholder API_DEPRECATED("已经废弃",ios(2.0,8.0));
/** 创建textfield */
+(nonnull instancetype)textFieldWithTextColor:(nonnull UIColor *)color size:(CGFloat)size placeholder: (nullable NSString *)placeholder placeholderColor:(nullable UIColor *)placeholderColor API_DEPRECATED("已经废弃",ios(2.0,8.0));
//- (instancetype)init API_DEPRECATED("Use -initRequiringSecureCoding: instead", macosx(10.12,10.14), ios(10.0,12.0), watchos(3.0,5.0), tvos(10.0,12.0));
/** 创建textfield */
+(nonnull instancetype)textFieldWithTextColor:(nonnull UIColor *)color font:(nonnull UIFont *)font placeholder:(nullable NSString *)placeholder placeholderColor:(nullable UIColor *)placeholderColor;

@end
