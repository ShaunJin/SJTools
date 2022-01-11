//
//  YwSyAlertView.m
//  YwSySDK
//
//  Created by youwan on 2018/6/5.
//  Copyright © 2018年 youwan. All rights reserved.
//

#import "SJAlertController.h"
#import "NSObject+SJObject.h"
@interface SJToastView : UIView
@property(nonatomic,strong)UILabel *textLabel;
@end

@implementation SJToastView
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel labelWithTextColor:Color(51, 51, 51) size:17];
        _textLabel.textAlignment = 1;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}
-(instancetype)init{
    CGFloat width = 240;
    CGFloat height = 44;
    CGRect frame = CGRectMake(ceil((kWidth - width) / 2), 0 - height, width, height);
    if (self = [super initWithFrame:frame]) {
        self.textLabel.frame = self.bounds;
        self.backgroundColor = [UIColor whiteColor];
        self.radius = height / 2;
    }
    return self;
}
+(void)showToast:(NSString *)toast{
    SJToastView *toastView = [SJToastView new];
    toastView.textLabel.text = toast;
    [[UIApplication sharedApplication].keyWindow addSubview:toastView];
    [UIView animateWithDuration:0.25 animations:^{
        toastView.top = kSafeAreaTop;
    }];
    [NSObject actionWithDelay:2 action:^{
        [UIView animateWithDuration:0.25 animations:^{
            toastView.bottom = 0;
        }];
    }];
}
@end

@interface SJAlertController ()
@property(nonatomic,strong)NSMutableArray *blockList;
@end

@implementation SJAlertController
/** toast */
+(void)makeToast:(NSString *)toast{
    [SJToastView showToast:toast];
}
/** 自定义标题及提示信息的弹窗 */
+(void)alertWithTitle:(NSString *)title message:(NSString *)message{
    [self makeAlertWithTitle:title message:message blockList:nil titleList:@[@"确定"]];
}
/** 在指定页面弹出自定义标题及提示信息的弹窗 */
+(void)alertWithTitle:(NSString *)title message:(NSString *)message onViewController:(UIViewController *)viewController{
    [self makeAlertWithTitle:title message:message blockList:nil titleList:@[@"确定"] onViewController:viewController];
}
/** 温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message{
    [self alertWithTitle:@"温馨提示" message:message];
}
/** 带bolck的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message block:(dispatch_block_t)block{
    [self makeAlertWithTitle:@"温馨提示" message:message blockList:@[block] titleList:@[@"确定"]];
}
/** 在指定页面弹出的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message onViewController:(UIViewController *)viewController{
    [self alertWithTitle:@"温馨提示" message:message onViewController:viewController];
}
/** 在指定页面弹出的带block的温馨提示 */
+(void)hintWarmlyWithMessage:(NSString *)message block:(dispatch_block_t)block onViewController:(UIViewController *)viewController{
    [self makeAlertWithTitle:@"温馨提示" message:message blockList:@[block] titleList:@[@"确定"] onViewController:viewController];
}
/** 错误提示 */
+(void)errorWithMessage:(NSString *)message{
    [self alertWithTitle:@"错误" message:message];
}
/** 在指定页面弹出错误提示 */
+(void)errorWithMessage:(NSString *)message onViewController:(UIViewController *)viewController{
    [self alertWithTitle:@"错误" message:message onViewController:viewController];
}

/** 创建弹窗 */
+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message blockList:(NSArray *)blockList titleList:(NSArray *)titleList{
    [self makeAlertWithTitle:title message:message blockList:blockList titleList:titleList onViewController:nil];
}
/** 在指定页面创建弹窗创建弹窗 */
+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message blockList:(NSArray *)blockList titleList:(NSArray *)titleList onViewController:(UIViewController *)viewController{
    NSString *msg = [NSString stringWithFormat:@"%@",message];
    SJAlertController *alertController = [SJAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < titleList.count; i++) {
        NSString *actionTitle = titleList[i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (blockList.count > i) {
                if ([self isBlock:blockList[i]]) {
                    dispatch_block_t block = (dispatch_block_t)blockList[i];
                    block();
                }
            }
        }];
        [alertController addAction:action];
    }
    if ([viewController isKindOfClass:[UIViewController class]]) {
        [viewController presentViewController:alertController animated:YES completion:nil];
    }else{
        [[UIViewController topViewController] presentViewController:alertController animated:YES completion:nil];
    }
}
/** 判断是否是block */
+(BOOL)isBlock:(id)pBlock
{
    NSString *className = NSStringFromClass([pBlock class]);
    return  [className isEqualToString:@"__NSMallocBlock__"]||
    [className isEqualToString:@"__NSStackBlock__"]||
    [className isEqualToString:@"__NSGlobalBlock__"];
}
@end
