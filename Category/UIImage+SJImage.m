//
//  UIImage+SJImage.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "UIImage+SJImage.h"
#import <objc/runtime.h>
@implementation UIImage (SJImage)
+ (UIImage*)greyImageWithImage:(UIImage*)image{
    //根据设备的屏幕缩放比例调整生成图片的尺寸，避免在图片变糊
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize resultSize = CGSizeMake(image.size.width*scale, image.size.height*scale);
    
    CGRect imageRect = CGRectMake(0, 0, resultSize.width, resultSize.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, resultSize.width, resultSize.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);//使用kCGImageAlphaPremultipliedLast保留Alpha通道，避免透明区域变成黑色。
    CGContextDrawImage(context, imageRect, [image CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    return newImage;
}
/** 彩色图片转换成黑白图片 */
-(UIImage*)greyImage{
    //根据设备的屏幕缩放比例调整生成图片的尺寸，避免在图片变糊
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize resultSize = CGSizeMake(self.size.width*scale, self.size.height*scale);
    
    CGRect imageRect = CGRectMake(0, 0, resultSize.width, resultSize.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, resultSize.width, resultSize.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);//使用kCGImageAlphaPremultipliedLast保留Alpha通道，避免透明区域变成黑色。
    CGContextDrawImage(context, imageRect, [self CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    return newImage;
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
/** 压缩图片 */
-(NSData *)zip{
    //进行图像尺寸的压缩
    CGSize imageSize = self.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    ///<1>.缩处理
    
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280 && height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280 && height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280 && height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    ///<2>压处理
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
            //            HSNSLog(@"%.2f",data.length/1024/1024.0);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
            //            HSNSLog(@"%.2f",data.length/1024/1024.0);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
            //            HSNSLog(@"%.2f",data.length/1024/1024.0);
        }
    }
    return data;
}
/** base64字符串转图片 */
+(UIImage *)imageWithString:(NSString *)str{
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [UIImage imageWithData:imageData ];
    return photo;
}
/** 图片转base64字符串 */
+(NSString *)imageDataToString:(NSData *)imagedata{
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
}
/** 将图片剪裁成指定大小（非缩放） */
-(UIImage *)clippingWithRect:(CGRect)rect{
    CGImageRef sourceImageRef = [self CGImage];//将UIImage转换成CGImageRef
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}
/* 以图片中心为中心，以最小边为边长，裁剪正方形图片 */
-(UIImage *)clippingSquareImage{
    CGFloat _imageWidth = self.size.width * self.scale;
    CGFloat _imageHeight = self.size.height * self.scale;
    CGFloat _width = _imageWidth > _imageHeight ? _imageHeight : _imageWidth;
    CGFloat _offsetX = (_imageWidth - _width) / 2;
    CGFloat _offsetY = (_imageHeight - _width) / 2;
    CGRect rect = CGRectMake(_offsetX, _offsetY, _width, _width);
    return [self clippingWithRect:rect];
}
@end
