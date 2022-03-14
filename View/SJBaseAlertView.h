//
//  SJBaseAlertView.h
//  CommonTools
//
//  Created by ShaJin on 2017/12/9.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 动画类型 */
typedef enum : NSUInteger {
    kAnimationCenter = 0,   // 原位置从小变大
    kAnimationBottom,       // 从屏幕下方飞入
} AnimationType;
/** 弹出视图的基类 */
@interface SJBaseAlertView : UIView
/** 点击菜单外消失  Default is YES */
@property(nonatomic,assign)BOOL dismissOnTouchOutside;
/** 圆角半径 Default is 5.0 */
@property(nonatomic,assign)CGFloat cornerRadius kDeprecated("直接使用UIView的radius方法");
/** 是否显示阴影 Default is YES */
@property(nonatomic,assign,getter=isShadowShowing) BOOL isShowShadow;
/** 出现方式 Default is kAnimationCenter */
@property(nonatomic,assign)AnimationType animationType;
/** 动画持续时间 Default is 0.25 */
@property(nonatomic,assign)CGFloat duration;
/** 出现 */
-(void)show;
/** 消失 */
-(void)dismiss;

@end
