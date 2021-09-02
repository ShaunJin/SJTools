//
//  SJDataBase.m
//  SJTools
//
//  Created by Clown on 2020/8/11.
//  Copyright © 2020 ShaJin. All rights reserved.
//

#import "SJDataBase.h"
#import "SJDataBaseModel.h"
//#import "FMDB.h"
#import <FMDB/FMDB.h>
#define kCheckClass(aClass) NSAssert1([aClass isSubclassOfClass:[SJDataBaseModel class]], @"传入了错误的类，%@不是SJDataBaseModel的子类", NSStringFromClass(aClass))
#define kCheckEmptyString(str,message)\
if ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<=0){\
NSLog(@"%@",%@);\
return;\
}\

@interface SJDataBaseModel()
/** 获取所有属性及对应SQLite类型 例：@{@"PropertyName":@"name",@"PropertyType":@"text"}  */
+(NSArray *)getPropertys;
/** 建表语句 */
+(NSString *)createSQL;
@end
@implementation SJDataBase
//+(void)createTableWithClass:(Class)aClass{
//    kCheckClass(aClass);
//    [self executeSQL:[aClass createSQL] useClass:aClass complete:nil];
//}
///** 用指定的tableName建表，不使用Class的tableName */
//+(void)createTableWithClass:(Class)aClass tableName:(NSString *)tableName{
//    kCheckClass(aClass);
//    
//}
#pragma mark- 数据库相关操作
/** 执行select语句 */
+(NSArray *)executeSelect:(NSString *)sql useClass:(Class)aClass{
    kCheckClass(aClass);
    NSLog(@"%@ executeSelect: %@",NSStringFromClass(aClass),sql);
    NSMutableArray *array = [NSMutableArray array];
    FMDatabase *db = [self open:aClass];
    if (db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            [array addObject:result.resultDictionary];
        }
    }
    return array;
}
/** 执行SQL语句 */
+(void)executeSQL:(NSString *)sql useClass:(Class)aClass complete:(nullable void(^)( NSError * _Nullable error))complete{
    kCheckClass(aClass);
    NSLog(@"excuteSQL:%@",sql);
    FMDatabase *db = [self open:aClass];
    if (db) {
        BOOL result = [db executeUpdate:sql];
        if (complete) {
            if (result) {
                complete(nil);
            }else{
                complete([db lastError]);
            }
        }
    }
}
+(FMDatabase *)open:(Class)aClass{
    kCheckClass(aClass);
    NSString *path = [self getPath:aClass];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        return db;
    }else{
        NSLog(@"数据库打开错误,path = %@",path);
        return nil;
    }
}
/** 表是否存在 */
+(BOOL)tableExists:(NSString*)tableName useClass:(Class)aClass{
    kCheckClass(aClass);
    FMDatabase *db = [self open:aClass];
    if (db) {
        return  [db tableExists:tableName];
    }
    return NO;
}
/** 字段是否存在 */
+(BOOL)columnExists:(NSString*)columnName inTableWithName:(NSString*)tableName useClass:(Class)aClass{
    kCheckClass(aClass);
    FMDatabase *db = [self open:aClass];
    if (db) {
        return  [db columnExists:columnName inTableWithName:tableName];
    }
    return NO;
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
