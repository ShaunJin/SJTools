//
//  SJDataBase.h
//  SJTools
//
//  Created by Clown on 2020/8/11.
//  Copyright © 2020 ShaJin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJDataBase : NSObject
///** 根据Model类创建表 */
//+(void)createTableWithClass:(Class)aClass;
///** 用指定的tableName建表，不使用Class的tableName */
//+(void)createTableWithClass:(Class)aClass tableName:(NSString *)tableName;
/** 执行SQL语句 */
+(void)executeSQL:(NSString *)sql useClass:(Class)aClass complete:(nullable void(^)( NSError * _Nullable error))complete;
/** 获取数据库文件路径 */
//+(NSString *)getPath:(Class)aClass;
/** 执行select语句 */
+(NSArray *)executeSelect:(NSString *)sql useClass:(Class)aClass;
/** 表是否存在 */
+(BOOL)tableExists:(NSString*)tableName useClass:(Class)aClass;
/** 字段是否存在 */
+(BOOL)columnExists:(NSString*)columnName inTableWithName:(NSString*)tableName useClass:(Class)aClass;
//+(NSArray *)select:(NSString *)select where:(NSString *)where useClass:(Class)aClass;
//-(instancetype)dbWithClass:(Class)aClass;
@end

NS_ASSUME_NONNULL_END
