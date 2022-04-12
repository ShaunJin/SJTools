//
//  UITableViewCell+SJTableViewCell.m
//  emerg
//
//  Created by Air on 2022/3/24.
//

#import "UITableViewCell+SJTableViewCell.h"

@implementation UITableViewCell (SJTableViewCell)
+(void)load{
    Method exchangeMethod = class_getInstanceMethod(self, @selector(initWithStyle:reuseIdentifier:));
    Method customMethod = class_getInstanceMethod(self, @selector(customInitWithStyle:reuseIdentifier:));
    method_exchangeImplementations(exchangeMethod, customMethod);
}
-(instancetype)customInitWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    [self customInitWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    return self;
}
@end
