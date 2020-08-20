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
@interface SJDataBaseModel()

@end
@implementation SJDataBaseModel
#pragma mark- 增、删、改、查
-(void)insert111{
    NSMutableArray *keys = [NSMutableArray array];
    NSMutableArray *values = [NSMutableArray array];
#pragma mark- Waring
    NSArray *propertys = [self getPropertys];
    NSLog(@"propertys = %@",propertys);
    for (NSDictionary *dict in propertys) {
        
        NSString *name = dict[kPropertyName];
        // TODO: 支持多种类型
        if (![name isEqualToString:[[self class] defaultPrimaryKey]]) {
            // 使用默认主键时，跳过这个键值
            id value = [self valueForKey:name];
            if (value) {
                [keys addObject:[NSString stringWithFormat:@"'%@'",name]];
                [values addObject:[NSString stringWithFormat:@"'%@'",value]];
            }
        }
    }
    NSString *key = [keys componentsJoinedByString:@","];
    NSString *value = [values componentsJoinedByString:@","];
    NSString *sql = [NSString stringWithFormat:@"insert into '%@' (%@) values (%@)",[[self class] tableName],key,value];
    [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
}
/** 插入数据库 */
-(void)insert{
    NSArray *propertys = [self getPropertys];
    NSString *key = [[self class] getKeysWith:propertys];
    NSString *value = [self getValuesWith:propertys];
    NSString *sql = [NSString stringWithFormat:@"insert into '%@' (%@) values %@",[[self class] tableName],key,value];
    [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
}
/** 批量插入数据，需要传待保存对象的数组 */
+(void)insertObjects:(NSArray *)array{
    NSArray *propertys = [self getPropertys];
    NSString *key = [[self class] getKeysWith:propertys];
    NSMutableArray *values = [NSMutableArray array];
    for (id obj in array) {
        if ([obj isKindOfClass:[SJDataBaseModel class]]) {
            SJDataBaseModel *model = (SJDataBaseModel *)obj;
            [values addObject:[model getValuesWith:propertys]];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"insert into '%@' (%@) values %@",[[self class] tableName],key,[values componentsJoinedByString:@","]];
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
                [values addObject:@""];
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
    NSLog(@"keys = %@",keys);
    return [keys componentsJoinedByString:@","];
}
/** 从数据库中删除 */
-(void)remove{
    NSString *where = [self where];
    if (where) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@",[self tableName],where];
        [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
    }else{
        NSLog(@"主键未赋值，删除失败");
    }
}
/** 修改数据 */
-(void)update{
    NSString *where = [self where];
    
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
        NSString *sql = [NSString stringWithFormat:@"update %@ set %@ where %@",[self tableName],[mArray componentsJoinedByString:@","],where];
        [SJDataBase executeSQL:sql useClass:[self class] complete:nil];
    }else{
        NSLog(@"主键未赋值，更新失败");
    }
}

/** 查询所有数据 */
+(NSArray *)selectAll{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from %@",[self tableName]];
    NSArray *result =  [SJDataBase executeSelect:sql useClass:[self class]];
    return [[self objectsWithArray:result] copy];
}
/** 根据主键查询，返回一个对象，未查询到返回nil） */
+(nullable id)selectByPrimaryId:(NSString *)primaryId{
    NSString *primaryKey = [self getRealPrimaryKey];
    NSString *where = [NSString stringWithFormat:@"%@ = '%@'",primaryKey,primaryId];
    NSArray *result = [SJDataBase select:@"*" where:where useClass:[self class]];
    if (result.count == 1) {
        return [self objectWithDictionary:result[0]];
    }
    return nil;
}
/** 自定义where条件的查询 */
+(NSArray *)selectByWhere:(NSString *)where{
    NSArray *result = [SJDataBase select:@"*" where:where useClass:[self class]];
    return [self objectsWithArray:result];
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
+(void)initialize {
    if ([self class] != [SJDataBaseModel class]) {
        [SJDataBase createTableWithClass:[self class]];
    }
}
#pragma mark- 类方法
/** 数据库路径，如果没有后缀则指的是文件夹路径，数据库文件自动命名为db.sqlite */
+(NSString *)dbPath{
    return [NSString stringWithFormat:@"%@/db.sqlite",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
}
/** 不会被存储的属性 */
+(NSArray *)ignoredPropertyNames{
    return @[@"test"];
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
            [model setValue:value forKey:@"primaryId" type:type];
            
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
#pragma mark- 实例方法
/** 设置属性值 */
- (void)setValue:(id)value forKey:(NSString *)key type:(NSString *)type{
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
    NSArray *propertys = [[self class] getPropertys];
    NSLog(@"propertys = %@",propertys);
    NSString *primaryKeyName = [self primaryKey];
    
    id primaryKey = [self valueForKey:@"primaryId"];
    if (primaryKey) {
        NSString *where = [NSString stringWithFormat:@"%@ = %@",primaryKeyName,primaryKey];
        return where;
    }
    return nil;
}
@end
