//
//  UIImage+SJImage.h
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SJImage)
/** 镂空纯色图片修改颜色 */
- (UIImage *)changeColor:(UIColor *)color;
/** 彩色图片转换成黑白图片 */
-(UIImage*)greyImage;
/** 生成纯色图片 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/** 压缩图片 */
-(NSData *)zip;
/** base64字符串转图片 */
+(UIImage *)imageWithString:(NSString *)str;
/** 图片转base64字符串 */
+(NSString *)imageDataToString:(NSData *)imagedata;
/** 图片转base64编码字符串 safeMode：是否使用url安全编码（字符串中的'/'等字符会被替换） */
-(NSString *)base64EncodeWithSafeMode:(BOOL)safeMode;
/** 将图片剪裁成指定大小（非缩放） */
-(UIImage *)clippingWithRect:(CGRect)rect;
/* 以图片中心为中心，以最小边为边长，裁剪正方形图片 */
-(UIImage *)clippingSquareImage;
/** 转换成NSData */
-(NSData *)toData;
@end
