//
//  UIButton+SJButton.m
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/3.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#import "UIButton+SJButton.h"

@interface UIButton()

@end
@implementation UIButton (SJButton)
/** 使用文字创建button */
+(instancetype)buttonWithTitle:(NSString *)title color:(UIColor *)color size:(CGFloat)size target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    if ([target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
/** 使用图片创建button */
+(instancetype)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:0];
    [button setImage:image forState:UIControlStateNormal];
    if ([target respondsToSelector:action]) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
@end
