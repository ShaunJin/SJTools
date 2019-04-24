//
//  UIViewController+SJViewController.m
//  renejin
//
//  Created by ShaJin on 2019/3/6.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import "UIViewController+SJViewController.h"

@implementation UIViewController (SJViewController)
/** 获取当前最顶层的ViewController */
+(UIViewController *)topViewController{
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+(UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
