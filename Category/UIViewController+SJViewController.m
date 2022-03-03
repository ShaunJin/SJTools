//
//  UIViewController+SJViewController.m
//  renejin
//
//  Created by ShaJin on 2019/3/6.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import "UIViewController+SJViewController.h"
#import <objc/runtime.h>
@implementation UIViewController (SJViewController)
+(void)load{
//    Method viewDidAppear = class_getInstanceMethod(self, @selector(viewDidAppear:));
//    Method customViewDidAppear = class_getInstanceMethod(self, @selector(customViewDidAppear:));
//    method_exchangeImplementations(viewDidAppear, customViewDidAppear);
    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method customViewWillAppear = class_getInstanceMethod(self, @selector(customViewWillAppear:));
    method_exchangeImplementations(viewWillAppear, customViewWillAppear);
}
-(void)customViewDidAppear:(BOOL)animated{
    [self customViewDidAppear:animated];
    if (self.navigationController) {
        if ([self isKindOfClass:[SJBaseViewController class]]) {
            SJBaseViewController *vc = (SJBaseViewController *)self;
            BOOL isClearNavigationBar = [vc isClearNavigationBar];
            NSDictionary *attr = @{
                NSForegroundColorAttributeName: [vc navigationTitleColor],
                NSFontAttributeName: [vc navigationTitleFont],
            };
            vc.navigationController.navigationBarHidden = [vc hiddenNavigationBar];
            if (@available(iOS 15.0, *)) {
                if (isClearNavigationBar) {
                    UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
                    barApp.backgroundColor = [UIColor clearColor];
                    #//基于backgroundColor或backgroundImage的磨砂效果
                    barApp.backgroundEffect = nil;
                    #//阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
                    barApp.shadowColor = nil;
                    //标题文字颜色
                    barApp.titleTextAttributes = attr;
                    self.navigationController.navigationBar.scrollEdgeAppearance = nil;
                    self.navigationController.navigationBar.standardAppearance = barApp;
                }else{
                    UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
                    barApp.backgroundColor = [vc navigationBarColor];
                    #//基于backgroundColor或backgroundImage的磨砂效果
                    barApp.backgroundEffect = nil;
                    #//阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
                    barApp.shadowColor = nil;
                    //标题文字颜色
                    barApp.titleTextAttributes = attr;
                    self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
                    self.navigationController.navigationBar.standardAppearance = barApp;
                }
                
            }else{
                self.navigationController.navigationBar.titleTextAttributes = attr;
                UIImage *navBgImg = [UIImage imageWithColor:ColorA(255, 255, 255, isClearNavigationBar ? 0.0f : 1.0f) size:CGSizeMake(kWidth, 44.f)];
                [self.navigationController.navigationBar setBackgroundImage:navBgImg forBarMetrics:UIBarMetricsDefault];
                UIImageView *bottomLine = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
                bottomLine.hidden = YES;
            }
            if (isClearNavigationBar) {
                //透明设置
                self.navigationController.navigationBar.translucent = YES;
                //navigationItem控件的颜色
                self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            }else{
                //透明设置
                self.navigationController.navigationBar.translucent = NO;
                //navigationItem控件的颜色
                self.navigationController.navigationBar.tintColor = [vc navigationTitleColor];
            }
        }
    }
}
-(void)customViewWillAppear:(BOOL)animated{
    [self customViewWillAppear:animated];
    if (self.navigationController) {
        if ([self isKindOfClass:[SJBaseViewController class]]) {
            SJBaseViewController *vc = (SJBaseViewController *)self;
            BOOL isClearNavigationBar = [vc isClearNavigationBar];
            NSDictionary *attr = @{
                NSForegroundColorAttributeName: [vc navigationTitleColor],
                NSFontAttributeName: [vc navigationTitleFont],
            };
            vc.navigationController.navigationBarHidden = [vc hiddenNavigationBar];
            if (@available(iOS 15.0, *)) {
                if (isClearNavigationBar) {
                    UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
                    barApp.backgroundColor = [UIColor clearColor];
                    #//基于backgroundColor或backgroundImage的磨砂效果
                    barApp.backgroundEffect = nil;
                    #//阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
                    barApp.shadowColor = nil;
                    //标题文字颜色
                    barApp.titleTextAttributes = attr;
                    self.navigationController.navigationBar.scrollEdgeAppearance = nil;
                    self.navigationController.navigationBar.standardAppearance = barApp;
                }else{
                    UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
                    barApp.backgroundColor = [vc navigationBarColor];
                    #//基于backgroundColor或backgroundImage的磨砂效果
                    barApp.backgroundEffect = nil;
                    #//阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
                    barApp.shadowColor = nil;
                    //标题文字颜色
                    barApp.titleTextAttributes = attr;
                    self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
                    self.navigationController.navigationBar.standardAppearance = barApp;
                }
                
            }else{
                self.navigationController.navigationBar.titleTextAttributes = attr;
                UIImage *navBgImg = [UIImage imageWithColor:ColorA(255, 255, 255, isClearNavigationBar ? 0.0f : 1.0f) size:CGSizeMake(kWidth, 44.f)];
                [self.navigationController.navigationBar setBackgroundImage:navBgImg forBarMetrics:UIBarMetricsDefault];
                UIImageView *bottomLine = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
                bottomLine.hidden = YES;
            }
            if (isClearNavigationBar) {
                //透明设置
                self.navigationController.navigationBar.translucent = YES;
                //navigationItem控件的颜色
                self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            }else{
                //透明设置
                self.navigationController.navigationBar.translucent = NO;
                //navigationItem控件的颜色
                self.navigationController.navigationBar.tintColor = [vc navigationTitleColor];
            }
        }
    }
}
/** 获取导航栏细线 */
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
/** 获取当前最顶层的ViewController */
+(UIViewController *)topViewController{
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in windows) {
        if (window.isKeyWindow) {
            resultVC = window.rootViewController;
            while (resultVC.presentingViewController) {
                resultVC = [self topViewController:resultVC.presentingViewController];
            }
            break;
        }
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
