//
//  UINavigationController+SJNavigationController.h
//  renejin
//
//  Created by ShaJin on 2019/2/18.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (SJNavigationController)
/**
 *  创建导航栏返回按钮
 
 @param imageName 按钮图片名字
 */
-(UIBarButtonItem *)getBackBtnItemWithImgName:(NSString *)imageName;

/**
 *  创建导航栏右侧图标按钮
 
 @param imageName 按钮图片名字
 */
-(UIBarButtonItem *)getRightBtnItemWithImgName:(NSString *)imageName target:(UIViewController *)vc method:(SEL)sel;

/** 创建导航栏右侧文字按钮 */
-(UIBarButtonItem *)getRightBtnItemWithTitle:(NSString *)title target:(UIViewController *)vc method:(SEL)sel;
/** 获取当前的导航控制器 */
+(UINavigationController *)getCurrentNavigationController;
@end

NS_ASSUME_NONNULL_END
