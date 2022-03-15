//
//  SJResource.h
//  emerg
//
//  Created by Air on 2022/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define SJLoadImage(imageName) [SJResource imageNamed:imageName]
@interface SJResource : NSObject
/** 获取全局实例 */
+(instancetype)shareInstance;
+(UIImage *)imageNamed:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
