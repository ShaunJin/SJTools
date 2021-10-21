//
//  SJTabBarController.m
//  EMBase
//
//  Created by Air on 2021/10/19.
//

#import "SJTabBarController.h"
#import "SJBaseViewController.h"
#import "SJNavigationController.h"
@interface SJTabBarController ()<UITabBarControllerDelegate>

@end

@implementation SJTabBarController
#pragma mark- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.title = viewController.title;
    if ([self.navigationController isKindOfClass:[SJNavigationController class]]) {
        SJNavigationController *navi = (SJNavigationController *)self.navigationController;
        [navi changePreferenceWithViewController:viewController];
    }
}
#pragma mark- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
}
-(void)addController:(UIViewController *)viewController title:(NSString *)title normolImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage{
    viewController.tabBarItem.title = title;
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = normalImage;
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectImage;
    // tabbar文字上移
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [self addChildViewController:viewController];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}
-(void) viewDidAppear:(BOOL)animated{
    [self.selectedViewController endAppearanceTransition];
}
-(void) viewWillDisappear:(BOOL)animated{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}
-(void) viewDidDisappear:(BOOL)animated{
    [self.selectedViewController endAppearanceTransition];
}
@end
