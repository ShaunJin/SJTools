//
//  SJDataBaseModel.m
//  SJTools
//
//  Created by Clown on 2020/8/11.
//  Copyright © 2020 ShaJin. All rights reserved.
//

#import "SJDataBaseModel.h"
#import "SJDataBase.h"
#import <objc/runtime.h>
#define kNSMutableString    @"T@\"NSMutableString\""
#define kText               @"TEXT"
#define kInteger            @"INTEGER"
#define kFloat              @"REAL"
#define kCheckTableName     if (!tableName) {\
tableName = [[self class] tableName];\
}
@interface SJDataBaseModel()

@end
@implementation SJDataBaseModel
#pragma mark- 增、删、改、查
/** 插入数据库 */
-(void)insert{
    [self insertObjectTo:[self tableName]];
}
-(void)insertObjectTo:(NSString *)tableName{
    NSArray *propertys = [self getPropertys];
    NSString *key = [[self class] getKeysWith:propertys];
    NSString *value = [self getValuesWith:propertys];
    NSString *sql = [NSString stringWithFormat:@"insert into '%@' (%@) values %@",tableName,key,value];
    [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
}
/** 批量插入数据，需要传待保存对象的数组 */
+(void)insertObjects:(NSArray *)array{
    [self insertObjects:array to:[self tableName]];
}
+(void)insertObjects:(NSArray *)array to:(NSString *)tableName{
    NSArray *propertys = [self getPropertys];
    NSString *key = [[self class] getKeysWith:propertys];
    NSMutableArray *values = [NSMutableArray array];
    for (id obj in array) {
        if ([obj isKindOfClass:[SJDataBaseModel class]]) {
            SJDataBaseModel *model = (SJDataBaseModel *)obj;
            [values addObject:[model getValuesWith:propertys]];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"insert into '%@' (%@) values %@",tableName,key,[values componentsJoinedByString:@","]];
    [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
}
-(NSString *)getValuesWith:(NSArray *)propertys{
    NSMutableArray *values = [NSMutableArray array];
    for (NSDictionary *dict in propertys) {
        NSString *name = dict[kPropertyName];
        NSString *type = dict[kPropertyAttributes];
        // TODO: 支持多种类型
        if (![name isEqualToString:[[self class] defaultPrimaryKey]]) {
            // 使用默认主键时，跳过这个键值
            id value = [self valueForKey:name];
            if (value) {
                if ([type isEqualToString:@""]) {
                    NSLog(@"特殊类型 %@",value);
                }else{
                    [values addObject:[NSString stringWithFormat:@"'%@'",value]];
                }
            }else{
                [values addObject:@"''"];
            }
        }
    }
    return [NSString stringWithFormat:@"(%@)",[values componentsJoinedByString:@","]]; 
}
+(NSString *)getKeysWith:(NSArray *)propertys{
    NSMutableArray *keys = [NSMutableArray array];
    for (NSDictionary *dict in propertys) {
        NSString *name = dict[kPropertyName];
        if (![name isEqualToString:[[self class] defaultPrimaryKey]]) {
            // 使用默认主键时，跳过这个键值
            [keys addObject:[NSString stringWithFormat:@"'%@'",name]];
        }
    }
    return [keys componentsJoinedByString:@","];
}
/** 从数据库中删除 */
-(void)remove{
    [self removeObjectFrom:[self tableName]];
}
-(void)removeObjectFrom:(NSString *)tableName{
    NSString *where = [self where];
    if (where) {
        NSString *sql = [NSString stringWithFormat:@"delete from '%@' where %@",tableName,where];
        [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
    }else{
        NSLog(@"主键未赋值，删除失败");
    }
}
+(void)removeByPrimaryId:(NSString *)primaryId{
    [self removeByPrimaryId:primaryId table:[self tableName]];
}
+(void)removeByPrimaryId:(NSString *)primaryId table:(NSString *)table{
    NSString *sql = [NSString stringWithFormat:@"delete from '%@' where %@ = '%@'",table,[self getRealPrimaryKey],primaryId];
    [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
}
/** 清空表(删除所有数据) */
+(void)clearTable{
    [self clearTableWithName:[self tableName]];
}
+(void)clearTableWithName:(NSString *)table{
    NSString *sql = [NSString stringWithFormat:@"delete from '%@'",table];
    [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
}
/** 修改数据 */
-(void)update{
    [self updateObjectAt:[self tableName]];
}
-(void)updateObjectAt:(NSString *)tableName{
    NSString *where = [self where];
//    id a = [[self class] selectByWhere:where table:tableName];
    NSInteger count = [[self class] selectCountByWhere:where table:tableName];
    if (count > 0) {
        // 更新
        NSLog(@"updateObjectAt更新 table = %@",tableName);
        if (where) {
            NSMutableArray *mArray = [NSMutableArray array];
    #pragma mark- Waring
            NSArray *propertys = [self getPropertys];
            for (NSDictionary *dict in propertys) {
                NSString *name = dict[kPropertyName];
                if (![name isEqualToString:[[self class] defaultPrimaryKey]]) {
                    // 使用默认主键时，跳过这个键值
                    id value = [self valueForKey:name];
                    if (value) {
                        [mArray addObject:[NSString stringWithFormat:@" %@ = '%@'",name,value]];
                    }
                }
            }
            NSString *sql = [NSString stringWithFormat:@"update '%@' set %@ where %@",tableName,[mArray componentsJoinedByString:@","],where];
            [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
        }else{
            NSLog(@"主键未赋值，更新失败");
        }
    }else{
        NSLog(@"updateObjectAt 插入 table = %@",tableName);
        // 插入
        [self insertObjectTo:tableName];
    }
}
/** 查询所有数据 */
+(NSArray *)selectAll{
    return [self selectAllObjectsFrom:[self tableName]];
}
/** 查询所有数据，带排序 */
+(NSArray *)selectAllOrderBy:(NSString *)order{
    NSString *sql = [NSString stringWithFormat:@"select * from '%@' order by %@",[self tableName],order];
    NSArray *result =  [SJDataBase executeSelect:sql useClass:[self class]];
    return [[self objectsWithArray:result] copy];
}
+(NSArray *)selectAllObjectsFrom:(NSString *)tableName{
    NSString *sql = [NSString stringWithFormat:@"select * from '%@'",tableName];
    NSArray *result =  [SJDataBase executeSelect:sql useClass:[self class]];
    return [[self objectsWithArray:result] copy];
}
/** 根据主键查询，返回一个对象，未查询到返回nil） */
+(nullable id)selectByPrimaryId:(NSString *)primaryId{
    return [self selectByPrimaryId:primaryId table:[self tableName]];
}
+(nullable id)selectByPrimaryId:(NSString *)primaryId table:(NSString *)table{
    NSString *primaryKey = [self getRealPrimaryKey];
    NSString *where = [NSString stringWithFormat:@"%@ = '%@'",primaryKey,primaryId];
    NSArray *result = [self select:@"*" table:table where:where];
    if (result.count == 1) {
        return result[0];
    }
    return nil;
}
/** 自定义where条件的查询 */
+(NSArray *)selectByWhere:(NSString *)where{
    return [self select:@"*" table:[self tableName] where:where];
}
+(NSArray *)selectByWhere:(NSString *)where table:(NSString *)table{
    return [self select:@"*" table:table where:where];
}
/** 自定义select和where的查询 */
+(NSArray *)select:(NSString *)select where:(NSString *)where{
    return  [self select:select table:[self tableName] where:where];
}
+(NSArray *)select:(NSString *)select table:(NSString *)table where:(NSString *)where{
    NSString *sql = [NSString stringWithFormat:@"select %@ from '%@' where %@",select,table,where];
    NSArray *result = [SJDataBase executeSelect:sql useClass:[self class]];
    return [[self objectsWithArray:result] copy];
}

/** 统计数量 */
+(NSUInteger)selectCountByWhere:(nullable NSString *)where{
    return [self selectCountByWhere:where table:[self tableName]];
}
+(NSUInteger)selectCountByWhere:(NSString *)where table:(NSString *)table{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"select count(*) from '%@'",table];
    if (where) {
        [sql appendFormat:@" where %@",where];
    }
    NSArray *result = [SJDataBase executeSelect:sql useClass:[self class]];
    if (result.count == 1) {
        NSDictionary *dict = result[0];
        return [dict[@"count(*)"] integerValue];
    }
    return 0;
}
+(NSArray *)select:(NSString *)select where :(NSString *)where orderBy:(NSString *)order limit:(int)limit{
    return [self select:select table:[self tableName] where:where orderBy:order limit:limit];
}
+(NSArray *)selectByWhere:(NSString *)where orderBy:(NSString *)order limit:(int)limit{
    return [self select:@"*" where:where orderBy:order limit:limit];
}
+(NSUInteger)selectCountByWhereDict:(nullable NSDictionary *)where{
    return [self selectCountByWhereDict:where table:[self tableName]];
}
+(NSUInteger)selectCountByWhereDict:(nullable NSDictionary *)where table:(NSString *)table{
    return [self selectCountByWhere:[self whereWithDict:where] table:table];
}
+(NSArray *)select:(NSString *)select table:(NSString *)tableName where :(NSString *)where orderBy:(NSString *)order limit:(int)limit{
    NSString *sql = [NSString stringWithFormat:@"select %@ from '%@' where %@ order by %@ limit %d",select,tableName,where,order,limit];
    NSArray *result = [SJDataBase executeSelect:sql useClass:[self class]];
    return [[self objectsWithArray:result] copy];
}
+(NSArray *)select:(NSString *)select table:(NSString *)tableName where :(NSString *)where orderBy:(NSString *)order limit:(int)limit offset:(int)offset{
    NSString *sql = [NSString stringWithFormat:@"select %@ from '%@' where %@ order by %@ limit %d offset %d",select,tableName,where,order,limit,offset];
    NSArray *result = [SJDataBase executeSelect:sql useClass:[self class]];
    return [[self objectsWithArray:result] copy];
}
#pragma mark- 初始化
/** 获取实际的主键名 */
+(NSString *)getRealPrimaryKey{
    return IsEmptyString([self primaryKey]) ? [self defaultPrimaryKey] : [self primaryKey];
}
/** 默认主键 */
+(NSString *)defaultPrimaryKey{
    return [NSString stringWithFormat:@"k_%@_id",NSStringFromClass([self class])];
}
#pragma mark- 类方法
/** 数据库路径，如果没有后缀则指的是文件夹路径，数据库文件自动命名为db.sqlite */
+(NSString *)dbPath{
    return [NSString stringWithFormat:@"%@/db.sqlite",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
}
/** 不会被存储的属性 */
+(NSArray *)ignoredPropertyNames{
    return @[];
}
/** 需要被替换的属性名 */
+(NSDictionary *)replacePropertyNames{
    return @{};
}
/** 主键名，主键数据不能重复 */
+(nullable NSString *)primaryKey{
    return nil;
}
/** 数据库表名，默认为类名 */
+(NSString *)tableName{
    return NSStringFromClass([self class]);
}

/** 获取所有属性 */
+(NSArray *)getPropertys{
    static NSDictionary *map;
    if (!map) {
        map = @{
            @"Ts":  kInteger,
            @"Ti":  kInteger,
            @"Tq":  kInteger,
            @"TQ":  kInteger,
            @"TB":  kInteger,
            @"Tc":  kInteger,
            @"Td":  kFloat,
            @"Tf":  kFloat,
            @"T@\"NSString\"" : kText,
            kNSMutableString  : kText,
        };
    }
    Class class = [self class];
    NSMutableArray *mArr = [NSMutableArray array];
    // 如果主键为空的话要添加默认主键
    if (IsEmptyString([self primaryKey])) {
        [mArr addObject:@{kPropertyName:[self defaultPrimaryKey],kPropertyType:@"INTEGER",kPrimaryKeyType:@"1",kPropertyAttributes:@"Ti"}];
    }
//    else{
//        [mArr addObject:@{kPropertyName:[self primaryKey],kPropertyType:@"INTEGER",kPrimaryKeyType:@"2",kPropertyAttributes:@"Ti"}];
//    }
    NSArray *ignoreList = [self ignoredPropertyNames];
    unsigned int count;// 记录属性个数
    while (class != [SJDataBaseModel class]) { // 到SJDataBase为止
        objc_property_t *properties = class_copyPropertyList(class, &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            // 获取属性名
            NSString *name = @(property_getName(property));
            if ([ignoreList containsObject:name]) {
                // 跳过忽略的属性名
                continue;
            }
            NSAssert(![name isEqualToString:@"index"], @"禁止在model中使用index作为属性,否则会引起语法错误");
            // 获取属性类型
            NSArray *arr = [@(property_getAttributes(property)) componentsSeparatedByString:@","];
//            NSLog(@"name = %@ type = %@",name,@(property_getAttributes(property)));
            if (arr.count > 0) {
                if (map[arr[0]]) {
                    NSString *type = map[arr[0]]; // 属性类型对应的字段类型
                    if ([name isEqualToString:[self primaryKey]]) {
                        [mArr insertObject:@{kPropertyName:name,kPropertyType:type,kPrimaryKeyType:@"2",kPropertyAttributes:arr[0]} atIndex:0];
                    }else{
                        [mArr addObject:@{kPropertyName:name,kPropertyType:type,kPropertyAttributes:arr[0]}];
                    }
                }
            }
        }
        free(properties);
        class = [class superclass];// 遍历父类
    }
    UITextField *fleld;
    fleld.keyboardType = UIKeyboardTypeDefault;
    return [mArr copy];
}
+(NSDictionary *)getPropertyMap{
    Class class = [self class];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int count;// 记录属性个数
    while (class != [SJDataBaseModel class]) { // 到SJDataBase为止
        objc_property_t *properties = class_copyPropertyList(class, &count);
        for (int i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            // 获取属性名
            NSString *name = @(property_getName(property));
            // 获取属性类型
            NSArray *arr = [@(property_getAttributes(property)) componentsSeparatedByString:@","];
            if (arr.count > 0) {
                NSString *type = arr[0];
                dict[name] = type;
            }
        }
    }
    return @{};
}
/** 根据字典构建对象 */
+(instancetype)objectWithDictionary:(NSDictionary *)dict{
    SJDataBaseModel *model = [[self class] new];
    NSArray *propertys = [self getPropertys];
    NSString *primaryKey = [self getRealPrimaryKey];
    for (NSDictionary *d in propertys) {
        NSString *key = d[kPropertyName];
        NSString *value = dict[key];
        NSString *type = d[kPropertyAttributes];
        if ([key isEqualToString:primaryKey]) {
            if (![key isEqualToString:[self defaultPrimaryKey]]) {
                [model setValue:value forKey:key type:type];
            }
        }else{
            [model setValue:value forKey:key type:type];
        }
    }
    return model;
}
/** 根据数组构建对象数据 */
+(NSArray *)objectsWithArray:(NSArray *)array{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [mArray addObject:[self objectWithDictionary:dict]];
    }
    return [mArray copy];;
}
/** 删除表,慎用 */
+(void)dropTable{
    [self dropTableWithName:[self tableName]];
}
+(void)dropTableWithName:(NSString *)table{
    
}

///** 建表语句 */
//+(NSString *)createSQL{
//    // TODO: 修改字段名称、增加删减字段等功能暂不支持
//    return [self createSQLWithName:[self tableName]];
//}
///** 建表语句 */
//+(NSString *)createSQLWithName:(NSString *)tableName{
//    NSMutableString *sql = [NSMutableString stringWithFormat:@"create table if not exists '%@' (",tableName];
//    NSArray *propertys = [self getPropertys];
//    for (NSDictionary *dict in propertys) {
//        NSString *name = dict[kPropertyName];
//        NSString *type = dict[kPropertyType];
//        if (dict[kPrimaryKeyType]) {
//            [sql appendFormat:@"'%@' %@ not null primary key %@",name,type,([dict[kPrimaryKeyType] intValue] == 1) ? @"AUTOINCREMENT" : @""];
//        }else{
//            [sql appendFormat:@", '%@' %@",name,type];
//        }
//    }
//    [sql appendString:@")"];
//    return sql;
//}
/** 建表 */
+(void)createTable{
    [self createTableWithName:[self tableName]];
}
/** 建表（指定表名，后续数据库操作都要指定表名） */
+(void)createTableWithName:(NSString *)tableName{
    // TODO: 修改字段名称、增加删减字段等功能暂不支持
    NSMutableString *sql = [NSMutableString stringWithFormat:@"create table if not exists '%@' (",tableName];
    NSArray *propertys = [self getPropertys];
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
    [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
}
+(void)TMPcreateTableWithName:(NSString *)tableName{
    // TODO: 修改字段名称、增加删减字段等功能暂不支持
    NSMutableString *sql = [NSMutableString stringWithFormat:@"create table if not exists '%@' (",tableName];
    NSArray *propertys = [self getPropertys];
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
    [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
}
#pragma mark- 实例方法
/** 设置属性值 */
- (void)setValue:(id)value forKey:(NSString *)key type:(NSString *)type{
//    NSLog(@"key = %@ value = %@ type = %@",key,value,type);
    if (value) {
        if ([type isEqualToString:kNSMutableString]) {
            NSMutableString *mStr = [NSMutableString stringWithFormat:@"%@",value];
            [self setValue:mStr forKey:key];
        }
        else{
            [self setValue:value forKey:key];
        }
    }
}
/** 主键名 */
-(nullable NSString *)primaryKey{
    return [[self class] getRealPrimaryKey];
}
/** 数据库表名，默认为类名 */
-(NSString *)tableName{
    return [[self class] tableName];
}
/** 获取所有属性 */
-(NSArray *)getPropertys{
    return [[self class] getPropertys];
}
/** 主键的where语句 */
-(nullable NSString *)where{
#pragma mark- Waring
//    NSArray *propertys = [[self class] getPropertys];
//    NSLog(@"propertys = %@",propertys);
    NSString *primaryKeyName = [self primaryKey];
    id primaryKey = [self valueForKey:primaryKeyName];
    
    if (primaryKey) {
        NSString *where = [NSString stringWithFormat:@"%@ = '%@'",primaryKeyName,primaryKey];
        return where;
    }
    return nil;
}
+(NSString *)whereWithDict:(nullable NSDictionary *)where{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSString *key in [where allKeys]) {
        NSString *value = where[key];
        [mArray addObject:[NSString stringWithFormat:@"%@ = '%@'",key,value]];
    }
    if (mArray.count > 0) {
        return [mArray componentsJoinedByString:@"and"];
    }
    return nil;
}
@end
