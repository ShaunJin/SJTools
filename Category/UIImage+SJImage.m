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
@end
