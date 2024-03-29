//
//  SJModel.h
//  EMBase
//
//  Created by ShaJin on 2021/4/12.
//
// 所有model的基类
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJModel : NSObject<NSSecureCoding>
/** 不归档的属性 */
+(NSArray *)ignoredCodingPropertyNames;
@end

NS_ASSUME_NONNULL_END
