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
//    if ([self.navigationController isKindOfClass:[SJNavigationController class]]) {
//        SJNavigationController *navi = (SJNavigationController *)self.navigationController;
//        [navi changePreferenceWithViewController:viewController];
//    }
}
#pragma mark- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
}

-(void)addController:(UIViewController *)viewController title:(NSString *)title normolImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage{
    if (!viewController) {
        viewController = [UIViewController new];
        viewController.view.backgroundColor = RandomColor;
    }
    viewController.title = title;
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


///**
// *  设置所有UITabBar
// */
//- (void)setupTabBar{
//    UITabBar *tabBar = [UITabBar appearance];
//    tabBar.barTintColor = [UIColor whiteColor];
//    tabBar.backgroundImage = [UIImage new];
//    tabBar.backgroundColor = [UIColor whiteColor];
//    tabBar.shadowImage = [UIImage new];
//    tabBar.tintColor = kThemeColor;
//    tabBar.translucent = NO;
//    [self dropShadowWithOffset:CGSizeMake(0, -2.5) radius:2 color:kShadowColor opacity:0.2];
//}
//
//- (void)dropShadowWithOffset:(CGSize)offset
//                      radius:(CGFloat)radius
//                       color:(UIColor *)color
//                     opacity:(CGFloat)opacity {
//
//    // Creating shadow path for better performance
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.tabBar.bounds);
//    self.tabBar.layer.shadowPath = path;
//    CGPathCloseSubpath(path);
//    CGPathRelease(path);
//
//    self.tabBar.layer.shadowColor = color.CGColor;
//    self.tabBar.layer.shadowOffset = offset;
//    self.tabBar.layer.shadowRadius = radius;
//    self.tabBar.layer.shadowOpacity = opacity;
//
//    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
//    self.tabBar.clipsToBounds = NO;
//}
@end
