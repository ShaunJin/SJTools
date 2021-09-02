//
//  SJFileManager.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJFileManager.h"
static NSBundle             *bundle;
@implementation SJFileManager
/** 存 */
+(void)save:(id<NSCoding>)object identifier:(NSString *)identifier{
    if (object) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        [self saveData:data identifier:identifier];
    }else{
        [self deleteObjectWithIdentifier:identifier];
    }
}
/** 存 */
+(void)saveData:(NSData *)data identifier:(NSString *)identifier{
    NSString *path = [NSString stringWithFormat:@"%@/%lu",[self holeDataPath],(unsigned long)identifier.hash];
    [data writeToFile:path atomically:YES];
}
/** 取 */
+(id)getObjectWithIdentifier:(NSString *)identifier{
    NSData *data = [self getDataWithIdentifier:identifier];
    if (data) {
        id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return object;
    }else{
        return nil;
    }
}
/** 取 */
+(NSData *)getDataWithIdentifier:(NSString *)identifier{
    NSString *path = [NSString stringWithFormat:@"%@/%lu",[self holeDataPath],(unsigned long)identifier.hash];
    return [NSData dataWithContentsOfFile:path];
}
/** 删 */
+(void)deleteObjectWithIdentifier:(NSString *)identifier{
    NSString *path = [NSString stringWithFormat:@"%@/%lu",[self holeDataPath],(unsigned long)identifier.hash];
    [self removeFile:path];
}
/** 数据保存文件夹名称，路径是~/Document/data */
+(NSString *)dataPath{
    return @"data";
}
/** 数据保存文件夹完整路径 */
+(NSString *)holeDataPath{
    NSString *path = [NSString stringWithFormat:@"%@/%@",[self documentPath],[self dataPath]];
    [self createDirectoryIfNotExistAtPath:path];
    return path;
}
/** 沙盒document文件夹路径 */
+(NSString *)documentPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}
/** 检查目录是否存在，如果不存在就创建 */
+(NSError *)createDirectoryIfNotExistAtPath:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [manager fileExistsAtPath:path isDirectory:&isDir];
    NSError *error = nil;
    if (isExist && isDir) {
        return error;
    }else{
        if ([manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            return error;
        }else{
            if (error) {
                return error;
            }
            NSMutableArray  *mArray = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@"/"]];
            [mArray removeLastObject];
            [mArray insertObject:@"" atIndex:0];
            [self createDirectoryIfNotExistAtPath:[mArray componentsJoinedByString:@"/"]];
            [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
            return error;
        }
    }
}
/** 删除文件 */
+(BOOL)removeFile:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        return [manager removeItemAtPath:path error:nil];
    }
    return NO;
}
/** 获取全局实例 */
+(instancetype)manager{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

@end
