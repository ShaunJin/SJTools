//
//  UIView+SJView.h
//  SJCommonTools
//
//  Created by ShaJin on 2017/11/2.
//  Copyright © 2017年 ShaJin. All rights reserved.
//
// UIView的扩展
#import <UIKit/UIKit.h>

@interface UIView (SJView)
/** 顶部Y值 */
@property(nonatomic,assign)CGFloat top;
/** 底部Y值 */
@property(nonatomic,assign)CGFloat bottom;
/** 左边X值 */
@property(nonatomic,assign)CGFloat left;
/** 右边X值 */
@property(nonatomic,assign)CGFloat right;
/** 中心点X值 */
@property(nonatomic,assign)CGFloat centerX;
/** 中心点Y值 */
@property(nonatomic,assign)CGFloat centerY;
/** 起始坐标 */
@property(nonatomic,assign)CGPoint origin;
/** 宽度 */
@property(nonatomic,assign)CGFloat width;
/** 高度 */
@property(nonatomic,assign)CGFloat height;
/** 尺寸大小 */
@property(nonatomic,assign)CGSize size;
/** 圆角 */
@property(nonatomic,assign)CGFloat radius;
/** 返回frame的参数 */
+(NSString *)frameDescription:(CGRect)frame;
/** 设置圆角 */
-(void)setCorner:(UIRectCorner)corner cornerRadii:(CGSize)size;
/** 添加阴影 */
- (void)dropShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity;
@end
