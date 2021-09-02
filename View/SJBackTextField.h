//
//  SJBackTextField.h
//  EMBase
//
//  Created by Air on 2021/4/28.
//
// 自带背景的TextField
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJBackTextField : UIView
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,assign)UIEdgeInsets backEdgeInsets;
@end

NS_ASSUME_NONNULL_END
