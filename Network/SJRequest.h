//
//  SJRequest.h
//  emerg
//
//  Created by Air on 2022/2/18.
//

#import "AFHTTPSessionManager.h"
#import "SJResponse.h"
/** HTTP请求类型 */
typedef NS_ENUM(NSInteger, SJHttpMethod) {
    kHttpGet = 0,       // GET
    kHttpPost = 1,      // POST
    kHttpPut = 2,       // PUT
    kHttpDelete = 3,    // DELETE
};

NS_ASSUME_NONNULL_BEGIN
typedef void (^SJProgressBlock)(NSProgress * progress);
typedef void (^SJCompleteBlock)(SJResponse * response);
typedef void (^SJSuccessBlock)(BOOL success);

@interface SJRequest : AFHTTPSessionManager
@property(nonatomic,strong)NSString *uri;
@property(nonatomic,assign)SJHttpMethod method;
@property(nonatomic,strong,readonly)NSDictionary *requestData; // 请求数据
@property(nonatomic,assign)BOOL requestLog;     // 是否开启请求日志
@property(nonatomic,assign)BOOL responseLog;    // 是否开启响应日志
@property(nonatomic,assign)BOOL showProgress;   // 是否显示菊花器
@property(nonatomic,strong)NSDictionary <NSString *, NSString *> *headers;
@property(nonatomic,copy)SJProgressBlock progressBlock;
@property(nonatomic,copy)SJCompleteBlock completeBlock;
/** 初始化 */
+(instancetype)requestWithUri:(NSString *)uri completeBlock:(nullable SJCompleteBlock)completeBlock;
-(instancetype)initWithUri:(NSString *)uri completeBlock:(nullable SJCompleteBlock)completeBlock;
-(BOOL)addValue:(id<NSCoding>)value forKey:(NSString *)key;
-(void)go;
/** URL前缀*/
-(NSString *)baseURL;
/** 使用的responseClass，必须是SJResponse或他的子类 */
-(Class)responseClass;
@end

NS_ASSUME_NONNULL_END
