//
//  NSMutableArray+SJArray.m
//  renejin
//
//  Created by Clown on 2019/6/3.
//  Copyright © 2019 ZhaoJin. All rights reserved.
//

#import "NSMutableArray+SJArray.h"

@implementation NSMutableArray (SJArray)
/** 移动数组中数据，拖动cell排序时使用 */
-(NSArray *)move:(NSInteger)oriIndex to:(NSInteger)toIndex{
    if (oriIndex < self.count && toIndex < self.count) {
        id object = self[oriIndex];
        [self removeObject:object];
        [self insertObject:object atIndex:toIndex];
    }else{
        NSLog(@"数组越界");
    }
    return self;
}
@end
