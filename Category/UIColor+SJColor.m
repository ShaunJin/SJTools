//
//  UIColor+SJColor.m
//  renejin
//
//  Created by ShaJin on 2019/3/12.
//  Copyright © 2019年 ZhaoJin. All rights reserved.
//

#import "UIColor+SJColor.h"

@implementation UIColor (SJColor)
-(CGFloat)r{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    return components[0];
}
-(CGFloat)g{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    return components[1];
}
-(CGFloat)b{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    return components[2];
}
-(CGFloat)a{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    return components[3];
}
/** 对比两个颜色的rgba值 */
BOOL isSameColor(UIColor *aColor ,UIColor *bColor){
    if ([aColor isKindOfClass:[UIColor class]] && [bColor isKindOfClass:[UIColor class]]) {
        const CGFloat *aComponents = CGColorGetComponents(aColor.CGColor);
        const CGFloat *bComponents = CGColorGetComponents(bColor.CGColor);
        for (int i = 0; i < 4; i++) {
            if (aComponents[i] != bComponents[i]) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}
@end
