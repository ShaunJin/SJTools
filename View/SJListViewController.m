//
//  SJListViewController.m
//  EMBase
//
//  Created by Air on 2021/4/8.
//

#import "SJListViewController.h"
#import "MJRefresh.h"
#import "SDAutoLayout.h"
@interface SJListViewController ()
@property(nonatomic,strong)dispatch_source_t list_timer;
@end

@implementation SJListViewController

#pragma mark- CustomMethod
-(void)loadedDataWithArray:(NSArray *)array isLast:(BOOL)isLast{
    if (array.count > 0) {
        [self.array addObjectsFromArray:array];
    }else{
        isLast = YES;
    }
    if ([self.scrollView respondsToSelector:@selector(reloadData)]) {
        [self.scrollView performSelector:@selector(reloadData)];
    }
    if (isLast) {
        [self.scrollView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.scrollView.mj_footer endRefreshing];
    }
    [self.scrollView.mj_header endRefreshing];
    self.showDefaultPage = (self.array.count == 0);
    self.scrollView.mj_footer.hidden = (self.array.count < 3) ; // 2018.01.31 当数据条数小于3条时不显示footer
}

-(void)addHeaderAction:(SEL)action{
    kWeakSelf;
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:action];
    self.scrollView.mj_header.refreshingBlock = ^{
        weakSelf.page = 1;
        weakSelf.scrollView.mj_footer.hidden = YES;
        weakSelf.showDefaultPage = NO;
    };
}
-(void)addFooterAction:(SEL)action{
    self.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:action];
    self.scrollView.mj_footer.hidden = YES;
}
-(void)addHeaderFooterAction:(SEL)action{
    [self addHeaderAction:action];
    [self addFooterAction:action];
}
-(void)beginLoadData{
    self.showDefaultPage = NO;
    [self.scrollView.mj_header beginRefreshing];
}
/** 结束加载 */
-(void)endedLoadData{
    [self.scrollView.mj_header endRefreshing];
    [self.scrollView.mj_footer endRefreshing];
    if ([self.scrollView respondsToSelector:@selector(reloadData)]) {
        [self.scrollView performSelector:@selector(reloadData)];
    }
}
#pragma mark- Setter
-(void)setScrollView:(UIScrollView *)scrollView{
    if (_scrollView) {
        [self.defaultPage removeFromSuperview];
        [_scrollView removeFromSuperview];
    }
    _scrollView = scrollView;
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:self.defaultPage];
    self.defaultPage.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    if ([self autoHeaderFooterAction]) {
        [self addHeaderAction:@selector(loadNewData)];
        [self addFooterAction:@selector(loadMoreData)];
    }
}
-(void)setShowDefaultPage:(BOOL)showDefaultPage{
    _showDefaultPage = showDefaultPage;
    self.scrollView.mj_footer.hidden = showDefaultPage;
    self.defaultPage.hidden = !showDefaultPage;
    if (_showDefaultPage) {
        self.defaultPage.hidden = NO;
        self.defaultPage.frame = CGRectMake(0, 0, self.scrollView.width, self.scrollView.height);
    }else{
        self.defaultPage.hidden = YES;
    }
}
#pragma mark- Getter
-(float)autoRefreshDuration{
    return 0;
}
-(BOOL)autoHeaderFooterAction{
    return YES;
}
-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(UIView *)defaultPage{
    if (!_defaultPage) {
        _defaultPage = [UIView new];
        _defaultPage.backgroundColor = self.view.backgroundColor;
        UIImageView *imageView = [UIImageView new];
//        imageView.image = EBLoadImage(@"icon_no_data");
        [_defaultPage addSubview:imageView];
        UILabel *label = [UILabel labelWithTextColor:Color(141, 141, 141) size:14];
        label.text = @"暂无数据";
        [_defaultPage addSubview:label];
        imageView.sd_layout.centerXEqualToView(_defaultPage).centerYEqualToView(_defaultPage).widthIs(182).heightIs(142);
        label.sd_layout.centerXEqualToView(_defaultPage).topSpaceToView(imageView,-32).heightIs(14).widthIs(label.textWidth);
        _defaultPage.hidden = YES;
    }
    return _defaultPage;
}
#pragma mark- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    float duration = [self autoRefreshDuration];
    if (duration > 0) {
        kWeakSelf;
        self.list_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        // 设定定时器延迟开始执行时间
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        // 设置时间间隔
        uint64_t interval = (uint64_t)(duration * NSEC_PER_SEC);
        dispatch_source_set_timer(self.list_timer, start, interval, 0);
        // 要执行的任务
        dispatch_source_set_event_handler(self.list_timer, ^{
            if (weakSelf.scrollView.contentOffset.y < 10) {
                [weakSelf loadNewData];
            }
        });
        // 启动定时器
        dispatch_resume(self.list_timer);
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.list_timer) {
        dispatch_cancel(self.list_timer);
    }
}
@end
