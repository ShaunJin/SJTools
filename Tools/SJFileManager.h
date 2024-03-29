//
//  SJFileManager.h
//  SJTools
//
//  Created by ShaJin on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//
/**
 * 存数据->文件
 * 这里实现的是NSData数据的存取删
 * 编解码由SJArchiver完成
 * 默认路径是~/Document/data
 * 如果修改的话可以继承这个类然后重写dataPath方法
 * 只需要传相对~/Document的路径
 */
#import "SJArchiver.h"

@interface SJFileManager : SJArchiver
/** 数据保存文件夹完整路径 */
+(NSString *)holeDataPath;
/** 数据保存文件夹路径名称，默认路径是~/Document/data，如果要修改的话可以继承这个类然后重写这个方法 */
+(NSString *)dataPath;
/** 检查目录是否存在，如果不存在就创建 */
+(NSError *)createDirectoryIfNotExistAtPath:(NSString *)path;
@end
