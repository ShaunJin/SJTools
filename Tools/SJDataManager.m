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
/** 存 */
+(void)save:(id<NSSecureCoding>)object identifier:(NSString *)identifier{
    if (object) {
        NSData *data = nil;
        if (@available(iOS 11.0, *)) {
            data = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:nil];
            
        } else {
            data = [NSKeyedArchiver archivedDataWithRootObject:object];
        }
        [kUserDefaults setObject:data forKey:identifier];
        [kUserDefaults synchronize];
    }else{
        [self deleteObjectWithIdentifier:identifier];
    }
}
/** 取，解码一个类 */
+(id)getObjectWithIdentifier:(NSString *)identifier useClass:(Class)cls{
    NSData *data = [kUserDefaults objectForKey:identifier];
    if (data) {
        if (@available(iOS 11.0, *)) {
            id object = [NSKeyedUnarchiver unarchivedObjectOfClass:cls fromData:data error:nil];
            return object;
        } else {
            id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return object;
        }
    }
    return nil;
}
/** 取，解码一个类，属性包含其他类 */
+(id)getObjectWithIdentifier:(NSString *)identifier useClasses:(NSSet<Class> *)classes{
    NSData *data = [kUserDefaults objectForKey:identifier];
    if (data) {
        if (@available(iOS 11.0, *)) {
            id object = [NSKeyedUnarchiver unarchivedObjectOfClasses:classes fromData:data error:nil];
            return object;
        } else {
            id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return object;
        }
    }
    
    return nil;
}
/** 取，解码一个包含实体类的数组 */
+(NSArray *)getArrayWithIdentifier:(NSString *)identifier useClass:(Class)cls{
    NSData *data = [kUserDefaults objectForKey:identifier];
    if (data) {
        if (@available(iOS 14.0, *)) {
            NSArray *array = [NSKeyedUnarchiver unarchivedArrayOfObjectsOfClass:cls fromData:data error:nil];
            return array;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return array;
#pragma clang diagnostic pop
        }
    }
    return nil;
}
/** 取，解码一个包含多个类实例的数组 */
+(NSArray *)getArrayWithIdentifier:(NSString *)identifier useClasses:(NSSet<Class> *)classes{
    NSData *data = [kUserDefaults objectForKey:identifier];
    if (data) {
        if (@available(iOS 14.0, *)) {
            NSArray *array = [NSKeyedUnarchiver unarchivedArrayOfObjectsOfClasses:classes fromData:data error:nil];
            return array;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return array;
#pragma clang diagnostic pop
        }
    }
    return nil;
}
/** 取，解码一个字典 */
+(NSDictionary *)getDictionaryWithIdentifier:(NSString *)identifier KeysOfClass:(Class)keyCls objectsOfClass:(Class)valueCls{
    NSData *data = [kUserDefaults objectForKey:identifier];
    if (data) {
        if (@available(iOS 14.0, *)) {
            NSDictionary *dict = [NSKeyedUnarchiver unarchivedDictionaryWithKeysOfClass:keyCls objectsOfClass:valueCls fromData:data error:nil];
            return dict;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return dict;
#pragma clang diagnostic pop
        }
    }
    return nil;
}
/** 取，解码一个包含多个类的字典 */
+(NSDictionary *)getDictionaryWithIdentifier:(NSString *)identifier KeysOfClasses:(NSSet<Class> *)keyClasses objectsOfClasses:(NSSet<Class> *)valueClasses{
    NSData *data = [kUserDefaults objectForKey:identifier];
    if (data) {
        if (@available(iOS 14.0, *)) {
            NSDictionary *dict = [NSKeyedUnarchiver unarchivedDictionaryWithKeysOfClasses:keyClasses objectsOfClasses:valueClasses fromData:data error:nil];
            return dict;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return dict;
#pragma clang diagnostic pop
        }
    }
    return nil;
}
/** 删 */
+(void)deleteObjectWithIdentifier:(NSString *)identifier{
    [kUserDefaults removeObjectForKey:identifier];
}
@end
