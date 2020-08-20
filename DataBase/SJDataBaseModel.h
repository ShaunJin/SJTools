//
//  SJDataBaseModel.h
//  SJTools
//
//  Created by Clown on 2020/8/11.
//  Copyright © 2020 ShaJin. All rights reserved.
//

/*~
 *  基类，model类要继承于这个类
 *  模型属性不能以index做属性，index为数据库关键字
 *  如果没有指定主键名会以k_ClassName_id作为主键
 *  属性支持char short int long longlong NSInteger NSUInteger float double NSString NSMutableString类型
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define kPropertyName           @"name"         // 属性名
#define kPropertyAttributes     @"attribute"    // 属性在OC中的类型
#define kPropertyType           @"type"         // 该属性在数据库中的类型
#define kPrimaryKeyType         @"keyType"      // 主键类型，使用默认主键type为1，使用自定义主键type为2

@interface SJDataBaseModel : NSObject
/** 主键键值  */
@property(nonatomic,strong,readonly)NSString *primaryId;
//@property(nonnull,assign)short
/**
 * 数据库路径
 * 需要从根目录开始的完整路径
 * 如果没有后缀则指的是文件夹路径，数据库文件自动命名为db.sqlite
 * 默认为../Documents/db.sqlite
 */
+(NSString *)dbPath;
/** 不会被存储的属性 */
+(NSArray *)ignoredPropertyNames;
/** 需要被替换的属性名 */
+(NSDictionary *)replacePropertyNames;
/** 主键名，主键数据不能重复，默认使用k_ClassName_id作为主键 */
+(nullable NSString *)primaryKey;
/** 数据库表名，默认为类名 */
+(NSString *)tableName;


#pragma mark- 增、删、改、查
/** 插入数据库 */
-(void)insert;
/** 批量插入数据，需要传待保存对象的数组 */
+(void)insertObjects:(NSArray *)array;
/** 从数据库中删除 */
-(void)remove;
/** 修改数据 */
-(void)update;
/** 查询所有数据 */
+(NSArray *)selectAll;
/** 自定义where条件的查询 */
+(NSArray *)selectByWhere:(NSString *)where;
/** 根据主键查询，返回一个对象，未查询到返回nil） */
+(nullable id)selectByPrimaryId:(NSString *)primaryId;
/** 根据字典构建对象 */
+(instancetype)objectWithDictionary:(NSDictionary *)dict;
/** 根据数组构建对象数据 */
+(NSArray *)objectsWithArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
