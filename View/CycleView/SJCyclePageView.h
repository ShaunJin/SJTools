//
//  SJCyclePageView.h
//  AnJian
//
//  Created by Air on 2021/9/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJCyclePageView : UIView
/** 分页栏的指示颜色 */
@property(nonatomic,strong)UIColor *indicatorTintColor;
/** 分页栏当前分页的指示颜色 */
@property(nonatomic,strong)UIColor *currentIndicatorTintColor;
/** 分页栏宽度 */
@property(nonatomic,assign)CGFloat indicatorWidth;
/** 分页栏高度 */
@property(nonatomic,assign)CGFloat indicatorHeight;
/** 当前分页宽度 */
@property(nonatomic,assign)CGFloat currentIndicatorWidth;
/** 各分页之间宽度 */
@property(nonatomic,assign)CGFloat space;
/** 当前位置 */
@property(nonatomic,assign)NSInteger currentPage;

-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
