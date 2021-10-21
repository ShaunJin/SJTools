//
//  SJTabBarController.h
//  EMBase
//
//  Created by Air on 2021/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJTabBarController : UITabBarController
/** 添加vc */
-(void)addController:(UIViewController *)viewController title:(NSString *)title normolImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage;
@end

NS_ASSUME_NONNULL_END
