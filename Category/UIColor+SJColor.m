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
@end
