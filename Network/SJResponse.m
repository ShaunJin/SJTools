//
//  SJResponse.m
//  emerg
//
//  Created by Air on 2022/2/18.
//

#import "SJResponse.h"

@implementation SJResponse
+(instancetype)parseResponse:(id)responseObject{
    SJResponse *response = [[self class] new];
    response.rawData = responseObject;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        if (dict[@"code"]){
            response.code = [dict[@"code"] integerValue];
        }
        if (dict[@"msg"]) {
            response.msg = dict[@"msg"];
        }else if (dict[@"message"]){
            response.msg = dict[@"message"];
        }
        if (dict[@"data"]) {
            response.data = dict[@"data"];
            if ([dict[@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *data = dict[@"data"];
                if (data[@"code"]) {
                    response.code = [data[@"code"] integerValue];
                }
                if (data[@"msg"]) {
                    response.msg = data[@"msg"];
                }
                if (data[@"data"]) {
                    response.data = data[@"data"];
                }
            }else if ([dict[@"data"] isKindOfClass:[NSNull class]]){
                if (dict[@"dataList"]) {
                    response.data = dict[@"dataList"];
                }
            }
        }else{
            if (dict[@"rows"]) {
                response.data = dict[@"rows"];
            }
            else{
                response.data = responseObject;
            }
        }
    }
    return response;
}
+(instancetype)responseWithError:(NSError *)error{
    SJResponse *response = [SJResponse new];
    response.isError = YES;
    response.msg = error.localizedDescription;
    return response;
}
@end
