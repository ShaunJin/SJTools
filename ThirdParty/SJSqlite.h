//
//  SJSqlite.h
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//
// Sqlite扩展，需要导入fmdb
#import <Foundation/Foundation.h>
@class FMDatabase;
@interface SJSqlite : NSObject
/** 表名 */
@property(nonatomic,strong)NSString *tableName;
/** 主键 */
@property(nonatomic,strong,readonly)NSString *primaryKey;
/** 数据库文件路径 */
@property(nonatomic,strong,readonly)NSString *dbPath;
/** 创建数据库语句(主键不用写) */
@property(nonatomic,strong,readonly)NSArray<NSString *> *createSQL;
///** 数据库字段，key是字段名，value是字段类型 */
//@property(nonatomic,strong,readonly)NSArray<NSString *> *keys;
/** 插入一条数据 */
-(BOOL)insertData:(NSDictionary *)data;
/** 删除一条数据 */
-(BOOL)deleteDataWhere:(NSDictionary *)data;
/** 根据主键删除一条数据 */
-(BOOL)deleteByPrimaryKey:(NSString *)key;
/** 根据主键更新一条数据 */
-(BOOL)updateData:(NSDictionary *)data byPrimaryKey:(NSString *)key;
/** 查询 */
-(NSArray *)select;
/** 条件查询 */
-(NSArray *)selectWhere:(NSDictionary *)where limit:(NSInteger)limit offset:(NSInteger)offset;
/** 获取实例 */
+(instancetype)sqlite;
/** 判断表是否存在 */
-(BOOL)existsTable:(NSString *)tableName;
/** 将查询结果处理成数组形式，（由子类重写该方法） */
-(NSArray *)executeResule:(NSArray *)result;
@end
