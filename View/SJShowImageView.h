//
//  SJShowImageView.h
//  EMBase
//
//  Created by Air on 2021/7/7.
//
// 全屏展示一张图片
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJShowImageView : UIImageView
+(void)showImage:(UIImage *)image startRect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
