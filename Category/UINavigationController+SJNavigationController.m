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
    [backBtn sizeToFit];
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

@end
