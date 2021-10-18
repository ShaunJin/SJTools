//
//  SJBaseSelectView.h
//  AnJian
//
//  Created by Air on 2021/9/24.
//
// 选择页面，从底部弹出，默认高度为300
#import "SJBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SJBaseSelectView : SJBaseAlertView
/** 标题 */
@property(nonatomic,strong)NSString *title;
/** 标题颜色，默认 53,54,62 */
@property(nonatomic,strong)UIColor *titleTintColor;
/** 确认按钮颜色 默认 68,156,255 */
@property(nonatomic,strong)UIColor *confirmTintColor;
/** 取消按钮颜色 默认 53,54,62 */
@property(nonatomic,strong)UIColor *cancelTineColor;


/** 点击了View上的确认按钮 */
-(void)confirmAction;
@end

NS_ASSUME_NONNULL_END
