//
//  SJDefines.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#ifndef SJDefines_h
#define SJDefines_h

/** 判断字符串是否为空 */
#define IsEmptyString(str) (([str isKindOfClass:[NSNull class]] || str == nil || [str length]<=0)? YES : NO )

/** 系统版本 */
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/** 加载本地图片 */
#define LoadImage(imageName) [UIImage imageNamed:imageName]

/** 判断系统版本是否大于某（含）版本 */
#define IsLaterVersion(version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= version)? (YES):(NO))

/** 屏幕宽高*/
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
/** 字号 */
#define kFontSize(size) [UIFont systemFontOfSize:size]
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
