//
//  UIImage+SJImage.h
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SJImage)
/** 图片转base64编码字符串 safeMode：是否使用url安全编码（字符串中的'/'等字符会被替换） */
-(NSString *)base64EncodeWithSafeMode:(BOOL)safeMode;
/** 镂空纯色图片修改颜色 */
- (UIImage *)changeColor:(UIColor *)color;
@end
