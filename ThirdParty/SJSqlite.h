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
@property(nonatomic,strong)NSString *primaryKey;
/** 数据库文件路径 */
@property(nonatomic,strong)NSString *dbPath;
/** 数据库句柄 */
@property(nonatomic,strong)FMDatabase *db;
/** 数据库字段，key是字段名，value是字段类型 */
@property(nonatomic,strong)NSArray *kays;
/** 插入一条数据 */
-(BOOL)insertData:(NSDictionary *)data;
/** 删除一条数据 */
-(BOOL)deleteDataWhere:(NSDictionary *)data;
/** 根据主键删除一条数据 */
-(BOOL)deleteByPrimaryKey:(NSString *)value;
/** 根据主键更新一条数据 */
-(BOOL)updateData:(NSDictionary *)data byPrimaryKey:(NSString *)value;
/** 查询 */
-(NSArray *)select;
/** 条件查询 */
-(NSArray *)selectLimit:(NSString *)limit offset:(NSString *)offset;
/** 获取实例 */
+(instancetype)sqlite;
@end
