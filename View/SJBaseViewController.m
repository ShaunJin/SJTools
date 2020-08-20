//
//  SJBaseViewController.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJBaseViewController.h"
#import "SJNavigationController.h"
@interface SJBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation SJBaseViewController
#pragma mark- CustomMethod
-(void)initUI{
}
-(void)loadData{
    
}
/** POP回到指定的界面 */
-(void)popToViewController:(NSString *)className{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:NSClassFromString(className)]) {
            [self.navigationController popToViewController:controller animated:YES];
            return;
        }
    }
}
#pragma mark- Setter
/** 设置右侧按钮（文字形式） */
-(UIButton *)setRightItemWithTitle:(NSString *)title action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:Color(51, 51, 51) forState:UIControlStateNormal];
    [button setTitleColor:Color(204, 204, 204) forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    return button;
}
//* 设置右侧按钮（图片形式）
-(UIButton *)setRightItemWithImage:(UIImage *)image action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    return button;
}
/** 设置左侧按钮（文字形式）这两个方法只能用其中一个，一个以上按钮时须要用传统方法添加 */
-(UIButton *)setLeftItemWithTitle:(NSString *)title action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:Color(51, 51, 51) forState:UIControlStateNormal];
    [button setTitleColor:Color(204, 204, 204) forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
    return button;
}
#pragma mark- Getter
/** 隐藏导航栏底部细线 */
-(BOOL)hiddenNaviLine{
    return YES;
}
/** 隐藏导航栏 */
-(BOOL)hiddenNavigationBar{
    return NO;
}
/** 状态栏样式 */
-(UIBarStyle)navigationBarStyle{
    return UIBarStyleDefault;
}
/** 导航栏背景颜色 */
-(UIColor *)navigationBarColor{
    return [UIColor whiteColor];
}
#pragma mark- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self loadData];
    if ([self.navigationController isKindOfClass:[SJNavigationController class]]) {
        SJNavigationController *navi = (SJNavigationController *)self.navigationController;
        navi.hiddenLine = [self hiddenNaviLine];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNotification];
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    SJBaseViewController *vc = isSelf ? self : (SJBaseViewController *)viewController;
    [navigationController setNavigationBarHidden:(isSelf && [vc hiddenNavigationBar])];
    navigationController.navigationBar.barStyle = [vc navigationBarStyle];
    navigationController.navigationBar.barTintColor = [vc navigationBarColor];
}
@end
