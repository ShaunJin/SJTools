//
//  SJSqlite.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//
// Sqlite扩展，需要导入fmdb
#import "SJSqlite.h"
#import <FMDB.h>
@implementation SJSqlite

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
        NSString *keys = [self.kays componentsJoinedByString:@","];
        NSString *sql = [NSString stringWithFormat:@"create table if not exists '%@' (%@)",self.tableName,keys];
        if (![self.db executeUpdate:sql]) {
            NSLog(@"数据表创建失败");
        }
    }
    return self;
}
/** 获取实例 */
+(instancetype)sqlite{
    return [self new];
}
@end
