//
//  SJAreaPickerView.h
//  renejin
//
//  Created by ShaJin on 2019/4/26.
//  Copyright © 2019 ZhaoJin. All rights reserved.
//

#import "SJBaseAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SJAreaPickerView : SJBaseAlertView
/** titleView背景颜色 默认rgb 234 234 234 */
@property(nonatomic,strong)UIColor *titleViewColor;
/** 确认和取消按钮文字颜色 默认rgb：13 95 255 */ 
@property(nonatomic,strong)UIColor *buttonColor;
-(instancetype)initWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area completeBlock:(void(^)(NSString *province, NSString *city, NSString *area))completeBlock;
@end

NS_ASSUME_NONNULL_END
