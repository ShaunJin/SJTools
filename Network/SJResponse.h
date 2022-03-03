//
//  SJResponse.h
//  emerg
//
//  Created by Air on 2022/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJResponse : NSObject
/** 原始数据 */
@property(nonatomic,strong)id rawData;
/** 实际使用的数据 */
@property(nonatomic,strong)id data;
/** 状态码 */
@property(nonatomic,assign)NSInteger code;
/** 信息 */
@property(nonatomic,strong)NSString *msg;
/** 是否是失败消息 */
@property(nonatomic,assign)BOOL isError;
/** 是否是成功消息 */
@property(nonatomic,readonly,assign)BOOL isSuccess;
+(instancetype)parseResponse:(id)responseObject;
+(instancetype)responseWithError:(NSError *)error;
@end



NS_ASSUME_NONNULL_END
