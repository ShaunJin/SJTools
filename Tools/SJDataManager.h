//
//  SJDataManager.h
//  AnJian
//
//  Created by Air on 2021/9/9.
//
// 存数据->NSUserDefaults
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJDataManager : NSObject
/** 存 */
+(void)save:(id<NSCoding>)object identifier:(NSString *)identifier;
/** 取，解码一个类 */
+(id)getObjectWithIdentifier:(NSString *)identifier useClass:(Class)cls;
/** 取，解码一个类，属性包含其他类 */
+(id)getObjectWithIdentifier:(NSString *)identifier useClasses:(NSSet<Class> *)classes;
/** 取，解码一个包含实体类的数组 */
+(NSArray *)getArrayWithIdentifier:(NSString *)identifier useClass:(Class)cls;
/** 取，解码一个包含多个类实例的数组 */
+(NSArray *)getArrayWithIdentifier:(NSString *)identifier useClasses:(NSSet<Class> *)classes;
/** 取，解码一个字典 */
+(NSDictionary *)getDictionaryWithIdentifier:(NSString *)identifier KeysOfClass:(Class)keyCls objectsOfClass:(Class)valueCls;
/** 取，解码一个包含多个类的字典 */
+(NSDictionary *)getDictionaryWithIdentifier:(NSString *)identifier KeysOfClasses:(NSSet<Class> *)keyClasses objectsOfClasses:(NSSet<Class> *)valueClasses;
/** 删 */
+(void)deleteObjectWithIdentifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
