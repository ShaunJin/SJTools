//
//  SJAuth.h
//  emerg
//
//  Created by Air on 2022/3/1.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, SJAuthType) {
    SJAuthTypeNone,     // 未开启
    SJAuthTypeTouchID,  // 指纹识别
    SJAuthTypeFaceID    // 面容识别
};
NS_ASSUME_NONNULL_BEGIN

@interface SJAuth : NSObject
+(SJAuthType)authType;
+(void)authWithCanPassword:(BOOL)canPassword successBlock:(void(^)(void))successBlock failureBlock:(void(^)(NSError *error))failureBlock passwordBlock:(nullable void(^)(void))passwordBlock;
@end

NS_ASSUME_NONNULL_END
