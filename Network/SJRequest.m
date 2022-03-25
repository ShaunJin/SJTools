//
//  SJRequest.m
//  emerg
//
//  Created by Air on 2022/2/18.
//

#import "SJRequest.h"
static NSMutableArray *requests = nil;
static AFNetworkReachabilityStatus networkStatus = AFNetworkReachabilityStatusUnknown;
@interface SJRequest()
@property(nonatomic,strong)NSMutableDictionary *data;
@end
@implementation SJRequest
#pragma mark- CustomMethod
-(void)go{
    if (!requests) {
        requests = [NSMutableArray array];
    }
    if (networkStatus != AFNetworkReachabilityStatusReachableViaWiFi && networkStatus != AFNetworkReachabilityStatusReachableViaWWAN) {
        // 没网的情况下不请求
        if (![requests containsObject:self]) {
            [requests addObject:self];
        }
        return;
    }
    [self startRequest];
    kWeakSelf;
    void (^successBlock)(NSURLSessionDataTask *, id) = ^void (NSURLSessionDataTask *task, id _Nullable responseObject){
        [weakSelf completeRequest:responseObject error:nil];
        if (weakSelf.completeBlock) {
            SJResponse *response = [[self responseClass] parseResponse: responseObject];
            weakSelf.completeBlock(response);
        }
    };
    void (^failureBlock)(NSURLSessionDataTask *, NSError *) = ^void(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        [weakSelf completeRequest:nil error:error];
        if (weakSelf.completeBlock) {
            SJResponse *response = [[self responseClass] responseWithError:error];
            weakSelf.completeBlock(response);
        }
    };
    NSString *url = [NSString stringWithFormat:@"%@%@",[self baseURL],self.uri];
    switch (self.method) {
        case kHttpPost:{
            [self POST:url parameters:self.requestData headers:self.headers progress:self.progressBlock success:successBlock failure:failureBlock];
        }break;
        case kHttpPut:{
            [self PUT:url parameters:self.requestData headers:self.headers success:successBlock failure:failureBlock];
        }break;
        case kHttpDelete:{
            [self DELETE:url parameters:self.requestData headers:self.headers success:successBlock failure:failureBlock];
        }break;
        case kHttpUpload:{
            NSDictionary *parameters = self.requestData;
            [self POST:url parameters:nil headers:self.headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSData *data = parameters[@"data"];
                NSString *name = parameters[@"name"];
                NSString *fileName = parameters[@"fileName"];
                NSString *mimeType = parameters[@"mimeType"];
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
            } progress:self.progressBlock success:successBlock failure:failureBlock];
        }break;
        // 默认为get
        default:{
            if (self.requestData.count > 0) {
                url = [url stringByAppendingFormat:@"?%@",[self buildHttpQueryStr:self.requestData]];
            }
            [self GET:url parameters:nil headers:self.headers progress:self.progressBlock success:successBlock failure:successBlock];
        }break;
    }
}
-(BOOL)addValue:(id<NSCoding>)value forKey:(NSString *)key{
    if (key && [key isKindOfClass:[NSString class]] && value) {
        self.data[key] = value;
        return YES;
    }
    return NO;
}
/** 根据字典创建url查询串 */
-(NSString *)buildHttpQueryStr:(NSDictionary *)data{
    return AFQueryStringFromParameters(data);
}
/** 开始请求 */
-(void)startRequest{
    // 打印请求日志
    if (self.requestLog) {
        NSLog(@"发起请求%@\ndata = %@",self.uri,self.requestData);
    }
    // 菊花器处理
    if (self.showProgress) {
        [SVProgressHUD show];
    }
}
/** 完成请求 */
-(void)completeRequest:(id)responseObject error:(NSError *)error{
    if ([requests containsObject:self]) {
        [requests removeObject:self];
    }
    if ([responseObject isKindOfClass:[NSError class]]) {
        error = (NSError *)responseObject;
    }
    // 打印接收日志
    if (self.responseLog) {
        if (error != nil) {
            NSLog(@"请求失败 uri:%@ error = %@",self.uri,error);
        }else{
            NSLog(@"请求成功 uri:%@\ndata = %@",self.uri,responseObject);
        }
    }
    // 菊花器处理
    if (self.showProgress) {
        [SVProgressHUD dismiss];
    }
    if (error) {
        [SJAlertController makeToast:error.localizedDescription];
    }
}
#pragma mark- Setter

#pragma mark- Getter
/** 使用的responseClass，必须是SJResponse或他的子类 */
-(Class)responseClass{
    return [SJResponse class];
}
-(NSDictionary *)requestData{
    return [self.data copy];
}
-(NSString *)baseURL{
    return @"";
}
#pragma mark- LifeCycle

/** 初始化 */
+(instancetype)requestWithUri:(NSString *)uri completeBlock:(nullable SJCompleteBlock)completeBlock{
    return [[[self class] alloc] initWithUri:uri completeBlock:completeBlock];
}
+(instancetype)get:(NSString *)uri completeBlock:(nullable SJCompleteBlock)completeBlock{
    SJRequest *r = [self requestWithUri:uri completeBlock:completeBlock];
    r.method = kHttpGet;
    return r;
}
+(instancetype)httpGet:(NSString *)uri completeBlock:(nullable SJCompleteBlock)completeBlock{
    SJRequest *r = [self requestWithUri:uri completeBlock:completeBlock];
    r.responseSerializer =  [AFHTTPResponseSerializer serializer];
    r.method = kHttpGet;
    return r;
}
+(instancetype)post:(NSString *)uri completeBlock:(nullable SJCompleteBlock)completeBlock{
    SJRequest *r = [self requestWithUri:uri completeBlock:completeBlock];
    r.method = kHttpPost;
    return r;
}
+(instancetype)upload:(NSString *)uri completeBlock:(nullable SJCompleteBlock)completeBlock{
    SJRequest *r = [self requestWithUri:uri completeBlock:completeBlock];
    r.requestSerializer = [AFPropertyListRequestSerializer serializer];
    r.method = kHttpUpload;
    return r;
}
-(instancetype)initWithUri:(NSString *)uri completeBlock:(nullable SJCompleteBlock)completeBlock{
    if (self = [super init]) {
        self.uri = uri;
        self.data = [NSMutableDictionary dictionary];
        /** 忽略证书验证 */
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        // 如果是需要验证自建证书，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        self.securityPolicy = securityPolicy;
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer =  [AFJSONResponseSerializer serializer];
        self.completeBlock = completeBlock;
    }
    return self;
}
+(void)load{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        networkStatus = status;
        if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
            for (SJRequest *request in requests) {
                [request go];
            }
        }
    }];
    [manager startMonitoring];
}
@end
