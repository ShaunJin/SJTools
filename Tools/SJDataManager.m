//
//  SJDataManager.m
//  AnJian
//
//  Created by Air on 2021/9/9.
//
// 存数据->NSUserDefaults
#import "SJDataManager.h"

@implementation SJDataManager
/** 存/改 */
+(void)saveData:(NSData *)data identifier:(NSString *)identifier{
    if (data) {
        [kUserDefaults setObject:data forKey:identifier];
        [kUserDefaults synchronize];
    }else{
        [self deleteObjectWithIdentifier:identifier];
    }
}
/** 取 */
+(NSData *)getDataWithIdentifier:(NSString *)identifier{
    return [kUserDefaults objectForKey:identifier];;
}
/** 删 */
+(void)deleteObjectWithIdentifier:(NSString *)identifier{
    [kUserDefaults removeObjectForKey:identifier];
}
@end
