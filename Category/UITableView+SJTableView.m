//
//  UITableView+SJTableView.m
//  renejin
//
//  Created by ShaJin on 2019/2/15.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import "UITableView+SJTableView.h"
#import <objc/runtime.h>

@implementation UITableView (SJTableView)
+(void)load{
    Method exchangeMethod = class_getInstanceMethod(self, @selector(initWithFrame:style:));
    Method customMethod = class_getInstanceMethod(self, @selector(customInitWithFrame:style:));
    method_exchangeImplementations(exchangeMethod, customMethod);
}
/** 批量注册CellClass{identifier:cellClassName} */
-(void)registerClass:(NSDictionary *)dict{
    for (NSString *key in [dict allKeys]) {
        [self registerClass:NSClassFromString(dict[key]) forCellReuseIdentifier:key];
    }
}
-(instancetype)customInitWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    [self customInitWithFrame:frame style:style];
    if (@available(iOS 15.0, *)) {
        self.sectionHeaderTopPadding = 0.0f;
        self.backgroundColor = [UIColor whiteColor];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}
@end
