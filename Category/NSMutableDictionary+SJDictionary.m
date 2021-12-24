//
//  NSMutableDictionary+SJDictionary.m
//  im
//
//  Created by Air on 2021/12/23.
//

#import "NSMutableDictionary+SJDictionary.h"
#import <objc/runtime.h>
@implementation NSMutableDictionary (SJDictionary)
+(void)load{
    Method  setValue = class_getInstanceMethod(self, @selector(setValue:forKey:));
    Method customSetValue = class_getInstanceMethod(self, @selector(customSetValue:forKey:));
    method_exchangeImplementations(setValue, customSetValue);
    Method setObject = class_getInstanceMethod(self, @selector(setObject:forKey:));
    Method customSetObject = class_getInstanceMethod(self, @selector(customSetObject:forKey:));
    method_exchangeImplementations(setObject, customSetObject);
}
-(void)customSetValue:(id)value forKey:(NSString *)key{
    if (value) {
        [self customSetValue:value forKey:key];
    }else{
        NSLog(@"设置了空值");
    }
}
-(void)customSetObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject) {
        [self customSetObject:anObject forKey:aKey];
    }else{
        NSLog(@"设置了空值");
    }
}
@end
