//
//  SJNavigationController.h
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJNavigationController : UINavigationController
/** 是否隐藏导航栏底部细线 */
@property(nonatomic,assign)BOOL hiddenLine;
/** 根据vc修改导航栏及状态栏样式 */
-(void)changePreferenceWithViewController:(UIViewController *)viewController;
/** 获取返回按钮 */
-(UIBarButtonItem *)getBackBarButtonItem;
@end
