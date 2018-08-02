//
//  UIButton+SJButton.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/3.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SJButton)
+(instancetype)buttonWithType:(UIButtonType)buttonType title:(NSString *)title image:(UIImage *)image backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)action;
@end
