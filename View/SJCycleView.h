//
//  SJCycleView.h
//  SJCycleView
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 Arron_zkh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJCycleView;
typedef NS_ENUM(NSInteger, KHScrollDirection){
    KHScrollDirectionFromRight = 0,
    KHScrollDirectionFromLeft = 1
};
@protocol SJAdViewDelegate <NSObject>
-(UIView *)adView:(SJCycleView *)adView viewForIndex:(NSInteger)index;

-(void)adView:(SJCycleView *)adView didSelectViewAtIndex:(NSInteger)index;

-(void)adView:(SJCycleView *)adView didShowViewAtIndex:(NSInteger)index;
@end
@interface SJCycleView : UIView
@property(nonatomic,weak)id<SJAdViewDelegate> delegate;

/** 广告轮播的时间间隔 */
@property (nonatomic, assign) NSTimeInterval timeInterval;
/** 底部分页栏的背景颜色 */
@property (nonatomic, weak)  UIColor *bottomViewColor;
/** 分页栏的指示颜色 */
@property (nonatomic, weak)  UIColor *pageIndicatorTintColor;
/** 分页栏当前分页的指示颜色 */
@property (nonatomic, weak)  UIColor *currentPageIndicatorTintColor;
/** 底部分页栏的高度 */
@property (nonatomic, assign)  CGFloat bottomViewHeight;
/** 底部分页栏的透明度 */
@property (nonatomic, assign)  CGFloat alpha;
/** 滚动的方向 */
@property (nonatomic, assign)  KHScrollDirection direction;
/** 隐藏底部分页栏的背景 */
@property (nonatomic, assign)  BOOL hideBottomView;
/** 隐藏底部分页栏 */
@property (nonatomic, assign)  BOOL hidePageControl;

@property(nonatomic,assign)NSInteger count;

- (void)startTimer;

- (void)stopTimer;

- (void)invalidateTimer;



@end
