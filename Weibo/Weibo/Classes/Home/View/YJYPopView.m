//
//  YJYPopView.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYPopView.h"

#define kMarginX 5
#define kMarginY 28
@interface YJYPopView ()

@property (nonatomic, weak)UIImageView *imageView;

@end

@implementation YJYPopView

-(UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage strechableImage:@"popover_background"]];
        imageView.userInteractionEnabled = YES;
        imageView.alpha = 0.8;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

//- (UIImageView *)containView
//{
//    if (_containView == nil) {
//        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.image = [UIImage resizableWithImageName:@"popover_background"];
//        imageView.userInteractionEnabled = YES;
//        [self addSubview:imageView];
//        _containView = imageView;
//    }
//    return _containView;
//}


+(instancetype)createPopView{
    YJYPopView *popView = [[YJYPopView alloc]initWithFrame:YJYKeyWindow.bounds];
    return popView;
}

- (void)showInRect:(CGRect)rect
{
    self.imageView.frame = rect;
    
    [YJYKeyWindow addSubview:self];
}


-(void)setContentView:(UIView *)contentView{

    _contentView = contentView;
    [self.imageView addSubview:_contentView];
}

-(void)layoutSubviews{
    CGFloat x = kMarginX;
    CGFloat y = kMarginY;
    CGFloat w = self.imageView.width - kMarginX * 2;
    CGFloat h = self.imageView.height - kMarginY * 2;
    _contentView.frame = CGRectMake(x, y, w, h);
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(popViewDidDismiss:)]) {
        [_delegate popViewDidDismiss:self];
    }
}

@end
