//
//  SJShowImageView.m
//  EMBase
//
//  Created by Air on 2021/7/7.
//

#import "SJShowImageView.h"
@interface SJShowImageView()
@property(nonatomic,assign)CGRect startRect;
@property(nonatomic,assign)CGRect endRect;
@property(nonatomic,strong)UIView *backgroundView;
@end
@implementation SJShowImageView
#pragma mark- CustomMethod
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = self.endRect;
        self.backgroundView.alpha = 1;
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0;
        self.frame = self.startRect;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
-(void)touchAction{
//    NSLog(@"touch dismiss");
    [self dismiss];
}
#pragma mark- Setter
#pragma mark- Getter
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];
        _backgroundView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchAction)];
        [_backgroundView addGestureRecognizer: tap];
    }
    return _backgroundView;
}
#pragma mark- LifeCycle
+(void)showImage:(UIImage *)image startRect:(CGRect)rect{
    SJShowImageView *imageView = [[SJShowImageView alloc] initWithImage:image rect:rect];
    [imageView show];
}
-(instancetype)initWithImage:(UIImage *)image rect:(CGRect)rect{
    // 根据图片长宽计算imageView的frame
//    NSLog(@"image : w = %f h = %f",image.size.width,image.size.height);
    CGFloat x,y,w,h;
    if (image.size.width / image.size.height > kWidth / kHeight) {
//        NSLog(@"flag 1");
        x = 0;
        w = kWidth;
        h = image.size.height * w / image.size.width;
        y = (kHeight - h ) / 2;
    }else{
//        NSLog(@"flag 2");
        y = 0;
        h = kHeight;
        w = image.size.width * h / image.size.height;
        x = (kWidth - w) / 2;
    }
//    NSLog(@"frame : x = %f y = %f w = %f h = %f",x,y,w,h);
    if (self = [super initWithFrame:rect]) {
        self.startRect = rect;
        self.endRect = CGRectMake(x, y, w, h);
        self.image = image;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
