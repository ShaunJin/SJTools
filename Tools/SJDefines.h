//
//  SJDefines.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#ifndef SJDefines_h
#define SJDefines_h
// 过期提醒
#define kDeprecated(instead) API_DEPRECATED(instead, macosx(10.2,10.14), ios(2.0,2.0), watchos(2.0,5.0), tvos(9.0,12.0))
/** 判断字符串是否为空 */
#define IsEmptyString(str) (([str isKindOfClass:[NSNull class]] || str == nil || [str length]<=0)? YES : NO )

/** 系统版本 */
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/** 加载本地图片 */
#define LoadImage(imageName) [UIImage imageNamed:imageName]

/** 判断系统版本是否大于某（含）版本 */
#define IsLaterVersion(version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= version)? (YES):(NO))
#define IOS_VERSION_9_OR_LATER IsLaterVersion(9.0)

#ifdef IOS_VERSION_9_OR_LATER

#define kRegFont             @"PingFangSC-Regular"
#define kMedFont             @"PingFangSC-Medium"
#define kSemFont             @"PingFangSC-Semibold"
#else

#define kRegFont             @"HelveticaNeue-Thin"
#define kMedFont             @"HelveticaNeue-Medium"

#endif
/** 判断是否是刘海屏幕 */
#define kHasSafeArea ({\
    int tmp = 0;\
    if (@available(iOS 11.0, *)) {\
        if (kMainWindow.safeAreaInsets.bottom > 0) {\
            tmp = 1;\
        }\
    }\
    tmp;\
})
/** 屏幕宽高*/
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define kScaleWidth(width)      kWidth * width / 375
#define kScaleHeight(height)    kHeight * height / 667

#define kStasusBarHeight     (kHasSafeArea ? 44.0 : 20.0)   // 状态栏高度
#define kNaviBarHeight       (kHasSafeArea ? 88.0 : 64.0)   // 导航栏高度（加上状态栏）
#define kTabBarHeight        (kHasSafeArea ? 83.0 : 49.0)   // tabBard高度（加上底部安全区域的）
#define kBottomHeight        (kHasSafeArea ? 34.0 : 0.0)    // 底部高度（有安全区域时是安全区域的高度，没有安全区域为0）

#define kHeightNoNaviBar            kHeight - kNaviBarHeight
#define kHeightNoNaviBarNoTabBar    kHeight - kNaviBarHeight - kTabBarHeight


/** 字号 */
#define kFontSize(fontSize) [UIFont fontWithName:kMedFont size:fontSize]
/** 颜色 */
#define Color(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define ColorA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])

/** 16进制数值颜色 */ // 调用 ：HEXRGB(0XFFFFFF)
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 随机颜色 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]

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
