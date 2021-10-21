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
/** 定时器 */
@property(nonatomic,strong)dispatch_source_t timer;
@end

@implementation SJBaseViewController
#pragma mark- CustomMethod
-(void)initUI{

}
-(void)loadData{
    
}
-(void)loadNewData{
    
}
-(void)loadMoreData{
    
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
    button.frame = CGRectMake(0, 0, 70, 44);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:Color(36,135,234) forState:UIControlStateNormal];
    [button setTitleColor:Color(85, 85, 85) forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, button.width - button.titleLabel.textWidth, 0,0);
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
    return button;
}
/** 设置右侧按钮（图片形式） */
-(UIButton *)setRightItemWithImage:(UIImage *)image action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
//    self.navigationController.navigationItem.rightBarButtonItem = buttonItem;
    return button;
}
/** 设置左侧按钮（文字形式） */
-(UIButton *)setLeftItemWithTitle:(NSString *)title action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 70, 20);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:Color(36,135,234) forState:UIControlStateNormal];
    [button setTitleColor:Color(85, 85, 85) forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, button.width - button.titleLabel.textWidth, 0,0);
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
    return button;
}
/** 设置左侧按钮（图片形式） */
-(UIButton *)setLeftItemWithImage:(UIImage *)image action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
    return button;
}
#pragma mark- Getter
/** 状态栏颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
/** 隐藏导航栏底部细线 */
-(BOOL)hiddenNaviLine{
    return YES;
}
/** 隐藏导航栏 */
-(BOOL)hiddenNavigationBar{
    return NO;
}
/** 标记该页面是否需要登录 */
-(BOOL)needLogin{
    return NO;
}
-(dispatch_source_t)timer{
    if (!_timer) {
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        // 设定定时器延迟开始执行时间
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0);
        // 设置时间间隔
        uint64_t interval = (uint64_t)([self refreshDuration] * NSEC_PER_SEC);
        dispatch_source_set_timer(timer, start, interval, 0);
        _timer = timer;
    }
    return _timer;
}
/** 定时刷新时间 */
-(float)refreshDuration{
    return -1;
}
/** 定时执行的方法 */
-(void)timerMethod{
    
}
#pragma mark- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
//这里是弃用的属性
    self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
    
    if ([self refreshDuration] > 0) {
        kWeakSelf;
        dispatch_source_set_event_handler(self.timer, ^{
            [weakSelf timerMethod];
        });
        dispatch_resume(self.timer);
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeNotification];
    if (_timer) {
        dispatch_cancel(_timer);
    }
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isSelf = [viewController isKindOfClass:[self class]];
    if (isSelf){
        [navigationController setNavigationBarHidden:(isSelf && [self hiddenNavigationBar]) animated:YES];
    }else if ([viewController isKindOfClass:[SJBaseViewController class]]){
        SJBaseViewController *baseViewController = (SJBaseViewController *)viewController;
        [navigationController setNavigationBarHidden:[baseViewController hiddenNavigationBar] animated:YES];
    }
}
@end
