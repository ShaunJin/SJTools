//
//  SJCollectionViewCell.m
//  emerg
//
//  Created by Air on 2022/3/3.
//

#import "SJCollectionViewCell.h"

@implementation SJCollectionViewCell
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}
-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        [self.contentView addSubview:_textLabel];
    }
    return _textLabel;
}
@end
