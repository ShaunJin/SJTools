//
//  SJNavigationController.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJNavigationController.h"

@interface SJNavigationController ()
{
    UIView *_line;
}
@end

@implementation SJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 去除导航栏底部细线
    UIImageView *bottomLine = [self findHairlineImageViewUnder:self.navigationBar];
    bottomLine.hidden = YES;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    // 自定义底部细线
    [self.navigationBar addSubview:self.line];
}
-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationBar.frame.size.height - 0.5, self.navigationBar.frame.size.width, 0.5)];
        _line.backgroundColor = Color(221, 221, 221);
    }
    return _line;
}
-(void)setLine:(UIView *)line{
    [_line removeFromSuperview];
    _line = line;
    _line.hidden = self.hiddenLine;
    [self.navigationBar addSubview:self.line];
}
-(void)setHiddenLine:(BOOL)hiddenLine{
    _hiddenLine = hiddenLine;
    _line.hidden = hiddenLine;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
@end
