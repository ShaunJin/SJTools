//
//  SJPickerView.h
//  AutoBooking
//
//  Created by youwan on 2018/8/2.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJBaseAlertView.h"

@interface SJPickerView : SJBaseAlertView
/** item选中时图标的颜色 */
@property(nonatomic,strong)UIColor *selectIconColor;
/** 行高 默认50 */
@property(nonatomic,assign)CGFloat rowHeight;
/** 选项中图标大小 默认40*40 */
@property(nonatomic,assign)CGSize  iconSize;
/** 最多显示个数 默认6个 */
@property(nonatomic,assign)int maxCount;
/** 多选 */
+(instancetype)pickerTitle:(NSString *)title icons:(NSArray<UIImage *> *)icons options:(NSArray<NSString *> *)options selectOptions:(NSArray<NSString *> *)selectOptions completeBlock:(void(^)(NSArray<NSString *> *selectOptions))completeBlock;
/** 单选 */
+(instancetype)pickerTitle:(NSString *)title icons:(NSArray<UIImage *> *)icons options:(NSArray<NSString *> *)options select:(NSString *)select completeBlock:(void (^)(NSString *select))completeBlock;
@end
