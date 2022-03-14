//
//  SJNavigationController.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJNavigationController.h"
#import "SJBaseViewController.h"
#import "SJTabBarController.h"
@interface SJNavigationController ()<UIGestureRecognizerDelegate>
//@property(nonatomic,strong)UIColor *currentBackgroundColor; // 当前导航栏背景颜色
@end

@implementation SJNavigationController
-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
#pragma mark侧滑返回的手势代理实现
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.viewControllers.count > 1;
}
#pragma mark- PUSH && POP
/** push */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count < 1){

    }else{
//        viewController.hidesBottomBarWhenPushed = YES;
        //-- wait to deal ImgName
//        viewController.navigationItem.leftBarButtonItem = [self getBackBarButtonItem];
    }
    [self changePreferenceWithViewController:viewController];
//    NSLog(@"pushViewController");
    [super pushViewController:viewController animated:YES];
}
/** pop */
//- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    if (self.viewControllers.count == 2) {
//        UIViewController *rootVC = self.viewControllers.firstObject;
//        if ([rootVC isKindOfClass:[SJTabBarController class]]) {
//            SJTabBarController *tabVC = (SJTabBarController *)rootVC;
//            [self changePreferenceWithViewController:tabVC.selectedViewController];
//        }
//    }
//    UIViewController *viewController = [super popViewControllerAnimated:animated];
//    return viewController;
//}
#pragma mark- CustomMethod
/** 根据vc修改导航栏及状态栏样式 */
-(void)changePreferenceWithViewController:(UIViewController *)viewController{
//    return;
//    if ([viewController isKindOfClass:[SJBaseViewController class]]) {
//        SJBaseViewController *vc = (SJBaseViewController *)viewController;
//        BOOL isClearNavigationBar = [vc isClearNavigationBar];
//        NSDictionary *attr = @{
//            NSForegroundColorAttributeName: [vc navigationTitleColor],
//            NSFontAttributeName: [vc navigationTitleFont],
//        };
//        self.navigationBarHidden = [vc hiddenNavigationBar];
//        if (@available(iOS 15.0, *)) {
//            if (isClearNavigationBar) {
//                UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
//                barApp.backgroundColor = [UIColor clearColor];
//                #//基于backgroundColor或backgroundImage的磨砂效果
//                barApp.backgroundEffect = nil;
//                #//阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
//                barApp.shadowColor = nil;
//                //标题文字颜色
//                barApp.titleTextAttributes = attr;
//                self.navigationBar.scrollEdgeAppearance = nil;
//                self.navigationBar.standardAppearance = barApp;
//            }else{
//                UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
//                barApp.backgroundColor = [vc navigationBarColor];
//                #//基于backgroundColor或backgroundImage的磨砂效果
//                barApp.backgroundEffect = nil;
//                #//阴影颜色（底部分割线），当shadowImage为nil时，直接使用此颜色为阴影色。如果此属性为nil或clearColor（需要显式设置），则不显示阴影。
//                barApp.shadowColor = nil;
//                //标题文字颜色
//                barApp.titleTextAttributes = attr;
//                self.navigationBar.scrollEdgeAppearance = barApp;
//                self.navigationBar.standardAppearance = barApp;
//            }
//
//        }else{
//            self.navigationBar.titleTextAttributes = attr;
//            UIImage *navBgImg = [UIImage imageWithColor:ColorA(255, 255, 255, isClearNavigationBar ? 0.0f : 1.0f) size:CGSizeMake(kWidth, 44.f)];
//            [self.navigationBar setBackgroundImage:navBgImg forBarMetrics:UIBarMetricsDefault];
////            UIImageView *bottomLine = [self findHairlineImageViewUnder:self.navigationBar];
////            bottomLine.hidden = YES;
//        }
//        if (isClearNavigationBar) {
//            //透明设置
//            self.navigationController.navigationBar.translucent = YES;
//            //navigationItem控件的颜色
//            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        }else{
//            //透明设置
//            self.navigationController.navigationBar.translucent = NO;
//            //navigationItem控件的颜色
//            self.navigationController.navigationBar.tintColor = [vc navigationTitleColor];
//        }
//    }
}
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
#pragma mark- Setter

#pragma mark- Getter
/** 获取返回按钮 */
-(UIBarButtonItem *)getBackBarButtonItem{
    return [self getBackBtnItemWithImgName:@"em_icon_back"];
}
#pragma mark- LifeCycle
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self changePreferenceWithViewController:rootViewController];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"viewDidLoad");
    // 去除导航栏底部细线
    UIImageView *bottomLine = [self findHairlineImageViewUnder:self.navigationBar];
    bottomLine.hidden = YES;
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.shadowImage = [UIImage new];
//    self.interactivePopGestureRecognizer.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
