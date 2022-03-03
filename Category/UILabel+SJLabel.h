//
//  UILabel+SJLabel.h
//  CommonTools
//
//  Created by ShaJin on 2017/11/29.
//  Copyright © 2017年 ShaJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SJLabel)
@property(nonatomic,assign)CGFloat textWidth;
/** 创建label */
+(instancetype)labelWithTextColor:(UIColor *)textColor size:(CGFloat)size;
+(instancetype)labelWithFontName:(NSString *)fontName color:(UIColor *)textColor size:(CGFloat)size kDeprecated("请使用labelWithFont:textColor:");
+(instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;
/** 根据text及指定宽度计算高度 */
-(CGFloat)heightWithWidth:(CGFloat)width;
/** 根据指定宽度自适应字号 */
-(void)suitFontForWidth:(CGFloat)width;
@end
