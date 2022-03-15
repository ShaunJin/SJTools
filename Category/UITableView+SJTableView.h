//
//  UITableView+SJTableView.h
//  renejin
//
//  Created by ShaJin on 2019/2/15.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SJTableView)
@property(nonatomic,strong)UIView *defaultPage;

/** 批量注册CellClass{identifier:cellClassName} */
-(void)registerClass:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
