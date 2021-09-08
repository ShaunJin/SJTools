//
//  SJCyclePageView.m
//  AnJian
//
//  Created by Air on 2021/9/8.
//

#import "SJCyclePageView.h"
@interface SJCyclePageView()
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSArray *views;
@end
@implementation SJCyclePageView
#pragma mark- CustomMethod
#pragma mark- Setter
-(void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    [self relayoutViews];
}
-(void)setIndicatorWidth:(CGFloat)indicatorWidth{
    _indicatorWidth = indicatorWidth;
    [self relayoutViews];
}
-(void)setIndicatorHeight:(CGFloat)indicatorHeight{
    _indicatorHeight = indicatorHeight;
    [self relayoutViews];
}
-(void)setCurrentIndicatorWidth:(CGFloat)currentIndicatorWidth{
    _currentIndicatorWidth = currentIndicatorWidth;
    [self relayoutViews];
}
-(void)setIndicatorTintColor:(UIColor *)indicatorTintColor{
    _indicatorTintColor = indicatorTintColor;
    [self relayoutViews];
}
-(void)setCurrentIndicatorTintColor:(UIColor *)currentIndicatorTintColor{
    _currentIndicatorTintColor = currentIndicatorTintColor;
    [self relayoutViews];
}
-(void)setSpace:(CGFloat)space{
    _space = space;
    [self relayoutViews];
}
#pragma mark- Getter
#pragma mark- LifeCycle
-(void)initViews{
    NSMutableArray *mArr = [NSMutableArray array];
    CGFloat y = (self.frame.size.height - self.indicatorHeight) / 2;
    CGFloat width = (self.count - 1) * (self.indicatorWidth + self.space) + self.currentIndicatorWidth;
    CGFloat x = (self.frame.size.width - width) / 2;
    for (int i = 0 ; i < self.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, self.indicatorWidth, self.indicatorHeight)];
        view.backgroundColor = self.indicatorTintColor;
        [self addSubview:view];
        [mArr addObject:view];
        x = x + self.indicatorWidth + self.space;
    }
    self.views = [mArr copy];
    [self relayoutViews];
}
-(void)relayoutViews{
    for (int i = 0; i < self.views.count; i++) {
        UIView *view = self.views[i];
        CGPoint center = view.center;
        if (i == self.currentPage) {
            view.width = self.currentIndicatorWidth;
            view.backgroundColor = self.currentIndicatorTintColor;
        }else{
            view.width = self.indicatorWidth;
            view.backgroundColor = self.indicatorTintColor;
        }
        view.center = center;
    }
}
-(void)initialize{
    _indicatorTintColor = Color(216, 216, 216);
    _currentIndicatorTintColor = Color(68, 156, 255);
    _indicatorWidth = 5.0f;
    _indicatorHeight = 2.0f;
    _currentIndicatorWidth = 10.0f;
    _space = 8.0f;
}
-(instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count{
    if (self = [super initWithFrame:frame]) {
        self.count = count;
        [self initialize];
        [self initViews];
    }
    return self;
}
@end
