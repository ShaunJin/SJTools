//
//  UIViewController+SJViewController.h
//  renejin
//
//  Created by ShaJin on 2019/3/6.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SJViewController)
/** 获取当前最顶层的ViewController */
+(UIViewController *)topViewController;
@end

NS_ASSUME_NONNULL_END
