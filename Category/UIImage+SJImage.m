//
//  UIImage+SJImage.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "UIImage+SJImage.h"

@implementation UIImage (SJImage)
/** 图片转base64编码字符串 safeMode：是否使用url安全编码（字符串中的'/'等字符会被替换） */
-(NSString *)base64EncodeWithSafeMode:(BOOL)safeMode{
    NSData *imageData = nil;
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    if ((alpha == kCGImageAlphaFirst || alpha == kCGImageAlphaLast || alpha == kCGImageAlphaPremultipliedFirst ||alpha == kCGImageAlphaPremultipliedLast)) {
        imageData = UIImagePNGRepresentation(self);
    }else{
        imageData = UIImageJPEGRepresentation(self, 1.0f);
    }
    NSData *base64Data = [imageData base64EncodedDataWithOptions:0];
    NSString *base64String = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    if (safeMode) {
        return [base64String encodeURIComponent];
    }else{
        return base64String;
    }
}
/** 镂空纯色图片修改颜色 */
- (UIImage *)changeColor:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/** 生成纯色图片 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+(void)load{
    Method imageNamed = class_getClassMethod(self, @selector(imageNamed:));
    Method customImageNamed = class_getClassMethod(self, @selector(customImageNamed:));
    method_exchangeImplementations(imageNamed, customImageNamed);
}
+(UIImage *)customImageNamed:(NSString *)name{
    UIImage *image = [UIImage customImageNamed:name];
    if (!image) {
        image = [UIImage imageWithColor:Color(175, 238, 238) size:CGSizeMake(100, 100)];
    }
    return image;
}
@end
