//
//  SJDefines.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#ifndef SJDefines_h
#define SJDefines_h

#define USE_SDK  //引用第三方库使用<sdk/sdk.h>形式,否则使用"sdk.h"
// 过期提醒
#define kDeprecated(instead) API_DEPRECATED(instead, macosx(10.2,10.14), ios(2.0,2.0), watchos(2.0,5.0), tvos(9.0,12.0))
/** 判断字符串是否为空 */
#define IsEmptyString(str) (([str isKindOfClass:[NSString class]] && [str length] > 0)? NO : YES )

/** 系统版本 */
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/** 加载本地图片 */
#define LoadImage(imageName) [UIImage imageNamed:imageName]

#define kRegFont             @"PingFangSC-Regular"
#define kMedFont             @"PingFangSC-Medium"
#define kSemFont             @"PingFangSC-Semibold"

/** 屏幕宽高*/
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

/** 状态栏高度 */
#define kNaviBarHeight    44

/** 字号 */
#define kFontSize(fontName, fontSize) [UIFont fontWithName:fontName size:fontSize]

/** 颜色 */
#define Color(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define ColorA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])
#define rgba(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
/** 16进制数值颜色 */ // 调用 ：HEXRGB(0XFFFFFF)
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 随机颜色 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]


#define kSafeAreaBottom ({\
    CGFloat tmp = 0;\
    if (@available(iOS 11.0, *)) {\
        tmp = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;\
    }\
    tmp;\
})
#define kSafeAreaTop ({\
    CGFloat tmp = 20;\
    if (@available(iOS 11.0, *)) {\
        tmp = [UIApplication sharedApplication].delegate.window.safeAreaInsets.top;\
    }\
    tmp;\
})
/** keyWindow */
#define kMainWindow  [UIApplication sharedApplication].keyWindow
/** 根视图 */
#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController
/** 快速声明block */
#define kBlock(block)               dispatch_block_t block = ^(){}
/** WeakSelf */
#define kWeakSelf __weak typeof(self) weakSelf = self;


#pragma mark- CustomMethod
#pragma mark- Setter
#pragma mark- Getter
#pragma mark- LifeCycle
#endif /* SJDefines_h */
