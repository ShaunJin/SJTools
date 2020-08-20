//
//  SJDataBase.m
//  SJTools
//
//  Created by Clown on 2020/8/11.
//  Copyright © 2020 ShaJin. All rights reserved.
//

#import "SJDataBase.h"
#import <sqlite3.h>
#import "SJDataBaseModel.h"

#define kCheckClass(aClass) NSAssert1([aClass isSubclassOfClass:[SJDataBaseModel class]], @"传入了错误的类，%@不是SJDataBaseModel的子类", NSStringFromClass(aClass))
#define kCheckEmptyString(str,message)\
if ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<=0){\
NSLog(@"%@",%@);\
return;\
}\

@interface SJDataBaseModel()
/** 获取所有属性及对应SQLite类型 例：@{@"PropertyName":@"name",@"PropertyType":@"text"}  */
+(NSArray *)getPropertys;
@end
@implementation SJDataBase
+(void)createTableWithClass:(Class)aClass{
    kCheckClass(aClass);
    // TODO: 修改字段名称、增加删减字段等功能暂不支持
    NSMutableString *sql = [NSMutableString stringWithFormat:@"create table if not exists '%@' (",[aClass tableName]];
#pragma mark- Waring 默认主键添加进来了 要解决
    NSArray *propertys = [aClass getPropertys];
//    NSLog(@"propertys = %@",propertys);
    for (NSDictionary *dict in propertys) {
        NSString *name = dict[kPropertyName];
        NSString *type = dict[kPropertyType];
        if (dict[kPrimaryKeyType]) {
            [sql appendFormat:@"'%@' %@ not null primary key %@",name,type,([dict[kPrimaryKeyType] intValue] == 1) ? @"AUTOINCREMENT" : @""];
        }else{
            [sql appendFormat:@", '%@' %@",name,type];
        }
    }
    [sql appendString:@")"];
//    NSLog(@"sql = %@",sql);
    [self executeSQL:sql useClass:aClass complete:nil];
}
#pragma mark- 数据库相关操作
+(NSArray *)select:(NSString *)select where:(NSString *)where useClass:(Class)aClass{
    select = IsEmptyString(select) ? @"*" : select;
    NSAssert(!IsEmptyString(where), @"where不能为空");
    NSString *sql = [NSString stringWithFormat:@"select %@ from %@ where %@",select,[aClass tableName],where];
    return [self executeSelect:sql useClass:aClass];
}
/** 执行select语句 */
+(NSArray *)executeSelect:(NSString *)sql useClass:(Class)aClass{
    kCheckClass(aClass);
    NSLog(@"%@ executeSelect: %@",NSStringFromClass(aClass),sql);
    NSMutableArray *array = [NSMutableArray array];
    sqlite3 *db = [self open:aClass];
#pragma mark- Waring
    NSArray *propertys = [aClass getPropertys];
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
            for (int i = 0; i < propertys.count; i++) {
                NSDictionary *dict = propertys[i];
                NSString *name = dict[kPropertyName];
                NSString *value = [self textForStmt:stmt at:i];
                if (name && value) {
                    mDict[name] = value;
                }
            }
            [array addObject:mDict];
        }
    }
    sqlite3_finalize(stmt);
    return [array copy];
}
+(nullable NSString *)textForStmt:(sqlite3_stmt *)stmt at:(int)index{
    const char * result = (const char *)sqlite3_column_text(stmt, index);
    return result ? [NSString stringWithUTF8String:result] : nil;
}
/** 执行SQL语句 */
+(void)executeSQL:(NSString *)sql useClass:(Class)aClass complete:(nullable void(^)( NSError * _Nullable error))complete{
    kCheckClass(aClass);
    NSLog(@"%@ executeSQL: %@",NSStringFromClass(aClass),sql);
    char *err = nil;
    sqlite3 *db = [self open:aClass];
    int result = sqlite3_exec(db, sql.UTF8String, nil, nil, &err);
    if (complete) {
        if (err) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:[NSString stringWithUTF8String:err]};
            NSError *error = [NSError errorWithDomain:@"SJSqlite" code:result userInfo:userInfo];
            complete(error);
        }else{
            complete(nil);
        }
    }
    [self close:db];
}
+(sqlite3 *)open:(Class)aClass{
    kCheckClass(aClass);
    sqlite3 *db = nil;
    NSString *path = [self getPath:aClass];
//    NSLog(@"DataBasePath = %@",path);
    sqlite3_open(path.UTF8String, &db);
    return db;
}
+(void)close:(sqlite3 *)db{
    sqlite3_close(db);
}
#pragma mark- CustomMethod
/** 获取数据库文件路径 */
+(NSString *)getPath:(Class)aClass{
    NSString *path = [aClass dbPath];
    if (![path hasSuffix:@".sqlite"]) {
        path = [NSString stringWithFormat:@"%@/db.sqlite",path];
    }
    [self checkPath:path];
    return path;
}
/** 检查路径是否存在，以免因为路径不存在而不能创建数据库文件，如果路径不存在，会自动创建各级文件夹 */
+(BOOL)checkPath:(NSString *)path{
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@"/"]];
    [mArr removeLastObject];
    NSString *superPath = [mArr componentsJoinedByString:@"/"]; // 上层文件夹路径
    if ([path hasSuffix:@".sqlite"]) {
        // 如果path是带.sqlite的完整路径，检查是否存在上层文件夹
        return [self checkPath:superPath];
    }else{
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
        if (isExist && isDir) {
            return YES;
        }else if (isExist && !isDir){
            NSLog(@"无法创建文件夹，因为存在相同名称的文件，请检查路径名称");
            return NO;
        }else{
            if ([self checkPath:superPath]) {
                return [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            }else{
                return NO;
            }
        }
    }
}
@end
