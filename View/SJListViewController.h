//
//  SJListViewController.h
//  EMBase
//
//  Created by Air on 2021/4/8.
//

#import "SJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SJListViewController : SJBaseViewController
/** TableView 或 CollectionView */
@property(nonatomic,weak)UIScrollView *scrollView;
/** 数据源 */
@property(nonatomic,strong)NSMutableArray *array;
/** 页数 */
@property(nonatomic,assign)NSInteger page;
/** 是否显示缺省页 */
@property(nonatomic,assign)BOOL showDefaultPage;
/** 缺省页 */
@property(nonatomic,strong)UIView *defaultPage;

/** 刷新数据相关 */
-(void)loadedDataWithArray:(NSArray *)array isLast:(BOOL)isLast;
/** 执行此方法之前要先设置ScrollView */
-(void)addHeaderAction:(SEL)action;
/** 执行此方法之前要先设置ScrollView */
-(void)addFooterAction:(SEL)action;
/** 同时设置以上两个 */
-(void)addHeaderFooterAction:(SEL)action;
/** 加载数据 */
-(void)beginLoadData;
/** 结束加载 */
-(void)endedLoadData;
/** 是否自动添加刷新方法 */
-(BOOL)autoHeaderFooterAction;
/** 返回值为自动刷新的间隔，为0或负值不自动刷新 */
-(float)autoRefreshDuration;
@end

NS_ASSUME_NONNULL_END
