//
//  SJCycleView.m
//  SJCycleView
//
//  Created by qianfeng on 16/9/25.
//  Copyright © 2016年 Aaron_zkh. All rights reserved.
//

#import "SJCycleView.h"

typedef NS_ENUM(NSInteger, KHSourceType){
    KHSourceOnlineType = 0,
    KHSourceLocalType = 1
};

@interface SJCycleView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak)  UICollectionView *collectionView;
/** 控制图片轮播的计时器 */
@property (nonatomic, strong)  NSTimer *timer;
/** 分页提示栏 */
@property (nonatomic, weak)  UIPageControl *pageControl;
/** 底部的pageControl的背景View */
@property (nonatomic, weak)  UIView *bottomView;

@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation SJCycleView
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = (scrollView.contentOffset.x / CGRectGetWidth(self.frame)) - 1;
    self.currentPage = currentPage;
    if (currentPage < 0){
        self.currentPage = self.count - 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        return;
    }else if (currentPage == self.count){
        self.currentPage = 0;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        return;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(adView:didSelectViewAtIndex:)]) {
        [self.delegate adView:self didSelectViewAtIndex:[self getIndexFromIndexPath:indexPath]];
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = self.count + 2;
    return count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    NSInteger index = [self getIndexFromIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(adView:viewForIndex:)]) {
        UIView *view = [self.delegate adView:self viewForIndex:index];
        [cell.contentView addSubview:view];
    }
    return cell;
}
#pragma mark- CustomMethod
-(NSInteger)getIndexFromIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.count - 1;
    }else if (indexPath.row == self.count + 1){
        return 0;
    }else{
        return indexPath.row - 1;
    }
}
#pragma mark- Setter
-(void)setDelegate:(id<SJAdViewDelegate>)delegate{
    _delegate = delegate;
    [self.collectionView reloadData];
    [self startTimer];
}
-(void)setCurrentPage:(NSInteger)currentPage{
    if (_currentPage != currentPage) {
        _currentPage = currentPage;
        self.pageControl.currentPage = currentPage;
        if ([self.delegate respondsToSelector:@selector(adView:didShowViewAtIndex:)]) {
            [self.delegate adView:self didShowViewAtIndex:currentPage];
        }
    }
}
#pragma mark- Getter

#pragma mark- LifeCycle
#pragma mark - Lazy load
- (UIView *)bottomView{
    if (!_bottomView ) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = self.bottomViewColor;
        view.alpha = self.alpha;
        [self addSubview:view];
        _bottomView = view;
        [self bringSubviewToFront:self.pageControl];
    }
    return _bottomView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        UIPageControl *pageC = [[UIPageControl alloc]init];
        pageC.currentPage = 0;
        
        [self addSubview:pageC];
        _pageControl = pageC;
    }
    _pageControl.numberOfPages = self.count;
    return _pageControl;
}


- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
      
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.bounces = NO;
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}




#pragma mark - SetUp Images




#pragma mark - Hanlde Timer
- (void)timerHandle{
    
    NSInteger curPage = self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.frame);
    NSInteger nextPage = 0;
    
    if (self.direction == KHScrollDirectionFromRight) {
        nextPage = curPage + 1;
        if (nextPage == self.count + 2) {
            nextPage = 2;
        }
    }else{
        nextPage = curPage - 1;
        if (nextPage < 0) {
            nextPage = self.count;
        }
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)startTimer{
    [self timer];
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Other methods
- (void)setHideBottomView:(BOOL)hideBottomView{
    _hideBottomView = hideBottomView;
    self.bottomView.hidden = hideBottomView;
}

- (void)setHidePageControl:(BOOL)hidePageControl{
    _hidePageControl = hidePageControl;
    self.pageControl.hidden = hidePageControl;
}

- (void)setAlpha:(CGFloat)alpha{
    _alpha = alpha;
    self.bottomView.alpha = alpha;
}

- (void)invalidateTimer{
    [self stopTimer];
}

#pragma mark - Init methods
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _currentPage = -1;
    _timeInterval = 2.f;
    _bottomViewColor = [UIColor blackColor];
    _pageIndicatorTintColor = [UIColor whiteColor];
    _currentPageIndicatorTintColor = [UIColor redColor];
    _bottomViewHeight = 30;
    _direction = KHScrollDirectionFromRight;
    _alpha = 0.3;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = self.bottomViewHeight;
    CGFloat y = CGRectGetHeight(self.frame) - height;
    
    self.bottomView.frame = CGRectMake(0, y, width, height);
    self.pageControl.frame = CGRectMake(0, y, width, height);
    
    self.pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
}

@end
