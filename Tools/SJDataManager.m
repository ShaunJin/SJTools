//
//  SJDataManager.m
//  AnJian
//
//  Created by Air on 2021/9/9.
//
// 存数据->NSUserDefaults
#import "SJDataManager.h"
#define kUserDefaults [NSUserDefaults standardUserDefaults]
@implementation SJDataManager
/** 存/改 */
+(void)saveData:(NSData *)data identifier:(NSString *)identifier{
    if (data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:identifier];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [self deleteObjectWithIdentifier:identifier];
    }
}
/** 取 */
+(NSData *)getDataWithIdentifier:(NSString *)identifier{
    return [[NSUserDefaults standardUserDefaults] objectForKey:identifier];;
}
/** 删 */
+(void)deleteObjectWithIdentifier:(NSString *)identifier{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:identifier];
}
@end
