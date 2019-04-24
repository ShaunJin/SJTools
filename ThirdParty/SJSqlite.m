//
//  SJSqlite.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//
// Sqlite扩展，需要导入fmdb
#import "SJSqlite.h"
#import "FMDB.h"
static id instance;
@interface SJSqlite ()
/** 数据库句柄 */
@property(nonatomic,strong)FMDatabase *db;
@end
@implementation SJSqlite
#pragma mark- CustomMethod
/** 插入一条数据 */
-(BOOL)insertData:(NSDictionary *)data{
    NSMutableString *keys = [NSMutableString string];
    NSMutableString *values = [NSMutableString string];
    NSMutableArray *arguments = [NSMutableArray array];
    for (NSString *key in [data allKeys]) {
        [keys appendFormat:@"%@,",key];
        [values appendString:@"?,"];
        [arguments addObject:data[key]];
    }
    while ([keys hasSuffix:@","]) {
        [keys deleteCharactersInRange:NSMakeRange(keys.length - 1, 1)];
    }
    while ([values hasSuffix:@","]) {
        [values deleteCharactersInRange:NSMakeRange(values.length - 1, 1)];
    }
    return [self.db executeUpdate:[NSString stringWithFormat:@"insert into '%@' (%@) values (%@)",self.tableName,keys,values] withArgumentsInArray:arguments];
}
/** 删除一条数据 */
-(BOOL)deleteDataWhere:(NSDictionary *)data{
    NSString *whereStr = [self getWhereStringWith:data];
    return [self executeDeleteWhere:whereStr arguments:nil];
}
/** 根据主键删除一条数据 */
-(BOOL)deleteByPrimaryKey:(NSString *)key{
    return [self executeDeleteWhere:[NSString stringWithFormat:@"%@ = ?",self.primaryKey] arguments:@[key]];
}
-(BOOL)executeDeleteWhere:(NSString *)where arguments:(NSArray *)arguments{
    return [self.db executeUpdate:[NSString stringWithFormat:@"delete from '%@' where %@",self.tableName,where] withArgumentsInArray:arguments];
}
/** 根据主键更新一条数据 */
-(BOOL)updateData:(NSDictionary *)data byPrimaryKey:(NSString *)key{
    return YES;
}
/** 查询 */
-(NSArray *)select{
    return [self selectWhere:nil limit:0 offset:0];
}
/** 条件查询 */
-(NSArray *)selectWhere:(NSDictionary *)where limit:(NSInteger)limit offset:(NSInteger)offset{
    return [self executeSelect:@"*" form:self.tableName where:where limit:limit offset:offset arguments:nil];
}
-(NSArray *)executeSelect:(NSString *)select form:(NSString *)from where:(NSDictionary *)where limit:(NSInteger)limit offset:(NSInteger)offset arguments:(NSArray *)arguments{
    NSMutableString *query = [NSMutableString stringWithFormat:@"select %@ from '%@' ",select ? select : @"*",from ? from : self.tableName];
    if ([where allKeys].count > 0) {
        [query appendString:[self getWhereStringWith:where]];
    }
    if (limit > 0) {
        [query appendFormat:@" limit %ld offset %ld",limit,offset];
    }
    return [self executeResule:[self excuteQuery:query arguments:arguments]];
}
/** 根据where字典构建where条件字符串 */
-(NSString *)getWhereStringWith:(NSDictionary *)data{
    NSMutableArray *whereArray = [NSMutableArray array];
    for (NSString *key in [data allKeys]) {
        [whereArray addObject:[NSString stringWithFormat:@"%@ = %@",key,data[key]]];
    }
    NSString *whereStr = [whereArray componentsJoinedByString:@" and "];
    return whereStr;
}
/** 建表 */
-(void)createTable{
    if (self.tableName.length > 0 && self.createSQL.count > 0) {
        NSString *keys = [NSString stringWithFormat:@"'%@' integer primary key autoincrement,%@",self.primaryKey,[self.createSQL componentsJoinedByString:@","]];
        NSString *sql = [NSString stringWithFormat:@"create table if not exists '%@' (%@)",self.tableName,keys];
        if ([self.db executeUpdate:sql]) {
            NSLog(@"创建数据库%@成功,path = %@",self.tableName,self.dbPath);
        }
    }
}
-(BOOL)existsTable{
    return [self existsTable:self.tableName];
}
-(BOOL)existsTable:(NSString *)tableName{
    NSString *query = [NSString stringWithFormat:@"select count(*) as 'count' from sqlite_master where type = 'table' and name = '%@'",tableName];
    NSArray *result = [self excuteQuery:query arguments:nil];
    if (result.count == 1) {
        NSDictionary *dict = result[0];
        NSLog(@"dict = %@",dict);
        return [dict[@"count"] intValue] == 1;
    }else{
        return NO;
    }
}
-(NSArray *)excuteQuery:(NSString *)query arguments:(NSArray *)arguments{
    FMResultSet *result = [self.db executeQuery:query withArgumentsInArray:arguments];
    NSMutableArray *mArray = [NSMutableArray array];
    while ([result next]) {
        NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
        for (int i = 0; i < result.columnCount; i++) {
            if (![result columnIndexIsNull:i]) {
                [mDict setObject:[result objectForColumnIndex:i] forKey:[result columnNameForIndex:i]];
            }
        }
        [mArray addObject:mDict];
    }
    return mArray;
}
-(NSArray *)executeResule:(NSArray *)result{
    return result;
}
#pragma mark- Setter
-(void)setTableName:(NSString *)tableName{
    _tableName = tableName;
    [self createTable];
}
#pragma mark- Getter
-(FMDatabase *)db{
    if (!_db) {
        _db = [FMDatabase databaseWithPath:self.dbPath];
        if (![_db open]) {
            NSLog(@"打开数据库出错");
        }
        [_db setShouldCacheStatements:YES];
    }
    return _db;
}
#pragma mark- 初始化
-(instancetype)init{
    if (self = [super init]) {
        [self createTable];
    }
    return self;
}
+(instancetype)sqlite{
    return [self new];
}
@end
