//
//  SJBaseViewController.h
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBaseViewController : UIViewController
/** 加载视图 这个方法是自动调用的，子类里只需重写就可以 */
-(void)initUI;
/** 请求数据 这个方法是自动调用的，子类里只需重写就可以 */
-(void)loadData;
/** 刷新数据 */
-(void)loadNewData;
/** 加载数据 */
-(void)loadMoreData;
/** 设置右侧按钮（文字形式）这两个方法只能用其中一个，一个以上按钮时须要用传统方法添加 */
-(UIButton *)setRightItemWithTitle:(NSString *)title action:(SEL)action;
/** 设置右侧按钮（图片形式）这两个方法只能用其中一个，一个以上按钮时须要用传统方法添加 */
-(UIButton *)setRightItemWithImage:(UIImage *)image action:(SEL)action;
/** 设置左侧按钮（文字形式）这两个方法只能用其中一个，一个以上按钮时须要用传统方法添加 */
-(UIButton *)setLeftItemWithTitle:(NSString *)title action:(SEL)action;
/** 设置左侧按钮（图片形式）这两个方法只能用其中一个，一个以上按钮时须要用传统方法添加 */
-(UIButton *)setLeftItemWithImage:(UIImage *)image action:(SEL)action;
/** POP回到指定的界面 */
-(void)popToViewController:(NSString *)className;
/** 定时刷新时间 */
-(float)refreshDuration;
/** 定时执行的方法 */
-(void)timerMethod;
#pragma mark- 样式
/** 隐藏导航栏 */
-(BOOL)hiddenNavigationBar;
/** 导航栏颜色 */
-(UIColor *)navigationBarColor;
/** 导航栏标题颜色 */
-(UIColor *)navigationTitleColor;
@end
