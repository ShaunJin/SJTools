//
//  UIButton+SJButton.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/3.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SJButton)
/** 使用文字创建button */
+(instancetype)buttonWithTitle:(NSString *)title color:(UIColor *)color size:(CGFloat)size target:(id)target action:(SEL)action;
/** 使用图片创建button */
+(instancetype)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action;
@end
