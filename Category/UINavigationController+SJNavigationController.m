//
//  UINavigationController+SJNavigationController.m
//  renejin
//
//  Created by ShaJin on 2019/2/18.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import "UINavigationController+SJNavigationController.h"

@implementation UINavigationController (SJNavigationController)
/**
 *  创建导航栏返回按钮
 
 @param imageName 按钮图片名字
 */
-(UIBarButtonItem *)getBackBtnItemWithImgName:(NSString *)imageName
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

/**
 *  pop控制器
 */
-(void)backClick
{
    [self popViewControllerAnimated:YES];
}

/**
 *  创建右侧导航栏图标按钮
 
 @param imageName 按钮图片名字
 */
-(UIBarButtonItem *)getRightBtnItemWithImgName:(NSString *)imageName target:(UIViewController *)vc method:(SEL)sel
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [backBtn addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}


/**
 *  创建右侧导航栏文字按钮
 
 */
-(UIBarButtonItem *)getRightBtnItemWithTitle:(NSString *)title target:(UIViewController *)vc method:(SEL)sel
{
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn sizeToFit];
    [Btn addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:Btn];
}
/** 获取当前的导航控制器 */
+(UINavigationController *)getCurrentNavigationController{
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = nil;
    if (@available(iOS 13.0, *)) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *window in windows) {
            if (window.isKeyWindow) {
                rootViewController = window.rootViewController;
                break;
            }
        }
    }else{
        rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return [self getCurrentNavigationControllerFrom:rootViewController];
}
//递归
+ (UINavigationController *)getCurrentNavigationControllerFrom:(UIViewController *)vc{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNavigationControllerFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNavigationControllerFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNavigationControllerFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNavigationControllerFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}
@end
