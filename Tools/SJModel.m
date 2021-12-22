//
//  SJModel.m
//  EMBase
//
//  Created by ShaJin on 2021/4/12.
//

#import "SJModel.h"
#import <objc/runtime.h>
@implementation SJModel
/** 归档 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int a;
    objc_property_t * result = class_copyPropertyList(object_getClass(self), &a);
    NSArray *ignoreArray = [[self class] ignoredCodingPropertyNames];
    for (unsigned int i = 0; i < a; i++) {
        objc_property_t o_t =  result[i];
        NSString *protertyName = [NSString stringWithFormat:@"%s",property_getName(o_t)];
        if ([ignoreArray containsObject:protertyName]) {
            continue;
        }
        [aCoder encodeObject:[self valueForKey:protertyName] forKey:protertyName];
    }
    free(result);
}
/** 解档 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int a;
        objc_property_t * result = class_copyPropertyList(object_getClass(self), &a);
        for (unsigned int i = 0; i < a; i++) {
            objc_property_t o_t =  result[i];
            NSString *protertyName = [NSString stringWithFormat:@"%s",property_getName(o_t)];
            NSString *value = [aDecoder decodeObjectForKey:protertyName];
            if (value) {
                [self setValue:value forKey:protertyName];
            }
        }
        free(result);
    }
    return self;
}
+ (BOOL)supportsSecureCoding{
    return YES;
}
/** 不归档的属性 */
+(NSArray *)ignoredCodingPropertyNames{
    return @[];
}
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{};
}

@end
