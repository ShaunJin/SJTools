//
//  UICollectionView+SJCollectionView.m
//  renejin
//
//  Created by Clown on 2019/3/15.
//  Copyright © 2019 ZhaoJin. All rights reserved.
//

#import "UICollectionView+SJCollectionView.h"

@implementation UICollectionView (SJCollectionView)
/** 批量注册CellClass{identifier:cellClassName} */
-(void)registerClass:(NSDictionary *)dict{
    for (NSString *key in [dict allKeys]) {
        [self registerClass:NSClassFromString(dict[key]) forCellWithReuseIdentifier:key];
    }
}
@end
