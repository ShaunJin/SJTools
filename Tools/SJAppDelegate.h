//
//  SJAppDelegate.h
//  SJTools
//
//  Created by Air on 2021/10/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJAppDelegate : UIResponder

+(instancetype)getApp;
/** 打开页面，支持push、present、http */
+(void)openView:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
