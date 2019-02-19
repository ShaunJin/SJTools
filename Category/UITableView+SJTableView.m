//
//  UITableView+SJTableView.m
//  renejin
//
//  Created by ShaJin on 2019/2/15.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import "UITableView+SJTableView.h"

@implementation UITableView (SJTableView)
/** 批量注册CellClass{identifier:cellClassName} */
-(void)registerClass:(NSDictionary *)dict{
    for (NSString *key in [dict allKeys]) {
        [self registerClass:NSClassFromString(dict[key]) forCellReuseIdentifier:key];
    }
}
@end
