//
//  SJDataBase.h
//  SJTools
//
//  Created by Clown on 2020/8/11.
//  Copyright © 2020 ShaJin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJDataBase : NSObject
/** 根据Model类创建表 */
+(void)createTableWithClass:(Class)aClass;
/** 执行SQL语句 */
+(void)executeSQL:(NSString *)sql useClass:(Class)aClass complete:(nullable void(^)( NSError * _Nullable error))complete;
/** 执行select语句 */
+(NSArray *)executeSelect:(NSString *)sql useClass:(Class)aClass;
+(NSArray *)select:(NSString *)select where:(NSString *)where useClass:(Class)aClass;
@end

NS_ASSUME_NONNULL_END
