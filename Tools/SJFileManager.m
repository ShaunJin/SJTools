//
//  SJFileManager.m
//  SJTools
//
//  Created by ShaJin on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJFileManager.h"
@implementation SJFileManager
#pragma mark- 存取相关
/** 存/改 */
+(void)saveData:(NSData *)data identifier:(NSString *)identifier{
    NSString *path = [NSString stringWithFormat:@"%@/%lu",[self holeDataPath],(unsigned long)identifier.hash];
    [data writeToFile:path atomically:YES];
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
#pragma mark- 文件相关
/** 数据保存文件夹完整路径 */
+(NSString *)holeDataPath{
    NSString *path = path = [NSString stringWithFormat:@"%@/%@",[self documentPath],[self dataPath]];
    [self createDirectoryIfNotExistAtPath:path];
    return path;
}
/** 数据保存文件夹名称，路径是~/Document/data */
+(NSString *)dataPath{
    return @"data";
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
///** 获取全局实例 */
//+(instancetype)manager{
//    static id manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[self alloc] init];
//    });
//    return manager;
//}

@end
