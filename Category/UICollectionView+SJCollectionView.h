//
//  UICollectionView+SJCollectionView.h
//  renejin
//
//  Created by Clown on 2019/3/15.
//  Copyright © 2019 ZhaoJin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (SJCollectionView)
/** 批量注册CellClass{identifier:cellClassName} */
-(void)registerClass:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
