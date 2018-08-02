//
//  UITextField+SJTextField.h
//  AutoBooking
//
//  Created by youwan on 2018/8/2.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SJTextField)
/** 创建textfield */
+(instancetype)textFieldWithTextColor:(UIColor *)color size:(CGFloat)size placeholder:(NSString *)placeholder;
@end
