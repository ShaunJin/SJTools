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

+(instancetype)buttonWithType:(UIButtonType)buttonType title:(NSString *)title image:(UIImage *)image backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:buttonType];
    if (title.length > 0) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (backImage) {
        [button setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
