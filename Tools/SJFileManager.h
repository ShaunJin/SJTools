//
//  SJFileManager.h
//  AutoBooking
//
//  Created by youwan on 2018/8/1.
//  Copyright © 2018年 gzsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJFileManager : NSObject
/** 沙盒document文件夹路径 */
@property(nonatomic,strong)NSString *documentPath;
/** 检查目录是否存在，如不存在则创建 */
-(void)checkPath:(NSString *)path;
/** 获取全局实例 */
+(instancetype)manager;
@end
