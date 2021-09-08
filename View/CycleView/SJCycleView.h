//
//  SJCycleView.h
//  SJCycleView
//
//  Created by ShaJin on 2021/9/8.
//

#import <UIKit/UIKit.h>
@class SJCycleView;
typedef NS_ENUM(NSInteger, SJScrollDirection){
    SJScrollDirectionFromRight = 0,
    SJScrollDirectionFromLeft = 1
};
@protocol SJAdViewDelegate <NSObject>
@required
/** 某个位置要显示的视图 */
-(UIView *)cycleView:(SJCycleView *)cycleView viewForIndex:(NSInteger)index;
@optional
/** 点击了某个view */
-(void)cycleView:(SJCycleView *)cycleView didSelectViewAtIndex:(NSInteger)index;
/** 正在展示某个view */
-(void)cycleView:(SJCycleView *)cycleView didShowViewAtIndex:(NSInteger)index;
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
@property (nonatomic, assign)  SJScrollDirection direction;
/** 隐藏底部分页栏的背景 */
@property (nonatomic, assign)  BOOL hideBottomView;
/** 隐藏底部分页栏 */
@property (nonatomic, assign)  BOOL hidePageControl;

@property(nonatomic,assign)NSInteger count;

- (void)startTimer;

- (void)stopTimer;

- (void)invalidateTimer;



@end
