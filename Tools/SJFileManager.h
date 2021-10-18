//
//  SJFileManager.h
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//
// 存文件
#import <Foundation/Foundation.h>

@interface SJFileManager : NSObject
/** 沙盒document文件夹路径 */
+(NSString *)documentPath;
/** 检查目录是否存在，如果不存在就创建 */
+(NSError *)createDirectoryIfNotExistAtPath:(NSString *)path;
/** 存 */
+(void)save:(id<NSCoding>)object identifier:(NSString *)identifier;
/** 存 */
+(void)saveData:(NSData *)data identifier:(NSString *)identifier;
/** 取 */
+(id)getObjectWithIdentifier:(NSString *)identifier;
/** 取 */
+(NSData *)getDataWithIdentifier:(NSString *)identifier;
/** 删 */
+(void)deleteObjectWithIdentifier:(NSString *)identifier;
@end
