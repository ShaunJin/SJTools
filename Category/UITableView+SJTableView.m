//
//  UITableView+SJTableView.m
//  renejin
//
//  Created by ShaJin on 2019/2/15.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import "UITableView+SJTableView.h"
#import <objc/runtime.h>
#import "SJResource.h"
static char *defaultPageChar = "defaultPage";
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
    }
    return self;
}
-(void)setDefaultPage:(UIView *)defaultPage{
    objc_setAssociatedObject(self, &defaultPageChar, defaultPage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)defaultPage{
    UIView *_defaultPage = objc_getAssociatedObject(self, &defaultPageChar);
    if (!_defaultPage) {
        _defaultPage = [UIView new];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:SJLoadImage(@"no_data")];
        [_defaultPage addSubview:imageView];
        imageView.sd_layout.topSpaceToView(_defaultPage, 0).centerXEqualToView(_defaultPage).widthIs(86).heightIs(70);
        UILabel *textLabel = [UILabel labelWithFont:kFontSize(kRegFont, 14) textColor:rgba(102, 102, 103, 1)];
        textLabel.textAlignment = 1;
        textLabel.text = @"暂无数据";
        [_defaultPage addSubview:textLabel];
        textLabel.sd_layout.centerXEqualToView(_defaultPage).topSpaceToView(imageView, 6).widthIs(textLabel.textWidth).heightIs(18);
        [self addSubview:_defaultPage];
        CGFloat width = 85;
        CGFloat height = 94;
        _defaultPage.frame = CGRectMake((self.width - width) / 2, (self.height - height) / 2,  width, height);
        _defaultPage.hidden = YES;
        objc_setAssociatedObject(self, &defaultPageChar, _defaultPage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _defaultPage;
}
@end
