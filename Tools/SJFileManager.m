//
//  SJFileManager.m
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import "SJFileManager.h"

@implementation SJFileManager
-(NSString *)documentPath{
    if (!_documentPath) {
        _documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    }
    return _documentPath;
}
/** 检查目录是否存在，如不存在则创建 */
-(void)checkPath:(NSString *)path{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
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
