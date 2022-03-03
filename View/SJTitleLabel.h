//
//  SJTitleLabel.h
//  emerg
//
//  Created by Air on 2022/2/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJTitleLabel : UILabel
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIColor *contentColor;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
+(instancetype)labelWithFont:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
