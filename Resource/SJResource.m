//
//  SJResource.m
//  emerg
//
//  Created by Air on 2022/3/15.
//

#import "SJResource.h"
static NSBundle             *bundle;
static SJResource *instance = nil;

@interface SJResource ()

@end

@implementation SJResource
#pragma mark- CustomMethod
/** 初始化 */
-(void)initSetup{
    
}
#pragma mark- Setter

#pragma mark- Getter
+(UIImage *)imageNamed:(NSString *)imageName{
    // 优先尝试加载倍图，如果没找到则加载原图
    NSString *newImageName = [NSString stringWithFormat:@"%@@%.0fx",imageName,[UIScreen mainScreen].scale];
    NSString *path = [bundle pathForResource:newImageName ofType:@"png"];
    if (!path) {
        path = [bundle pathForResource:imageName ofType:@"png"];
    }
    NSLog(@"path = %@",path);
    return [UIImage imageWithContentsOfFile:path];
}
#pragma mark- LifeCycle
+(instancetype)shareInstance{
    @synchronized (self) {
        if (instance == nil) {
            return [[self alloc] init];
        }
    }
    return instance;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        [instance initSetup];
    });
    return instance;
}
+(void)load{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SJResource" ofType:@"bundle"];
    if (!path) {
        NSLog(@"资源文件加载失败");
        return;
    }
    bundle = [NSBundle bundleWithPath:path];
}
@end
