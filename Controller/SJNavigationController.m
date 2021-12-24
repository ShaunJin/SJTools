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
@interface SJNavigationController (){

}
@end

@implementation SJNavigationController
#pragma mark- PUSH && POP
/** push */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count < 1){
        
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
        //-- wait to deal ImgName
        viewController.navigationItem.leftBarButtonItem = [self getBackBarButtonItem];
        //         ------ 设置返回手势
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    [self changePreferenceWithViewController:viewController];
    [super pushViewController:viewController animated:YES];
}
/** pop */
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count == 2) {
        UIViewController *rootVC = self.viewControllers.firstObject;
        if ([rootVC isKindOfClass:[SJTabBarController class]]) {
            SJTabBarController *tabVC = (SJTabBarController *)rootVC;
            [self changePreferenceWithViewController:tabVC.selectedViewController];
        }
    }
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    return viewController;
}
#pragma mark- CustomMethod
/** 根据vc修改导航栏及状态栏样式 */
-(void)changePreferenceWithViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[SJBaseViewController class]]) {
        SJBaseViewController *vc = (SJBaseViewController *)viewController;
        BOOL hiddenNavigationBar = [vc hiddenNavigationBar];
        self.navigationBarHidden = hiddenNavigationBar;
        // 隐藏导航栏时不用设置导航栏颜色
        if (!hiddenNavigationBar) {
            [[UINavigationBar appearance] setBarTintColor:[vc navigationBarColor]];
            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[vc navigationTitleColor]}];
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        // 修改状态栏样式
        [[UIApplication sharedApplication] setStatusBarStyle:[vc preferredStatusBarStyle]];
#pragma clang diagnostic pop
    }
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
    return [self getBackBtnItemWithImgName:@"btn_back"];
}
#pragma mark- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 去除导航栏底部细线
    UIImageView *bottomLine = [self findHairlineImageViewUnder:self.navigationBar];
    bottomLine.hidden = YES;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
