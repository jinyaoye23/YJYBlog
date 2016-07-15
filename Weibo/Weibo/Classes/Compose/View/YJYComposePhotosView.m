//
//  YJYComposePhotosView.m
//  Weibo
//
//  Created by yaojinye on 16/7/11.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYComposePhotosView.h"

@implementation YJYComposePhotosView

-(void)setImage:(UIImage *)image{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    
    [self addSubview:imageView];
}
//每添加一个子控件就会调用， 特殊如果在viewDidLoad添加子控件不会调用
-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    
    CGFloat wh = (self.width - (cols - 1) * margin) / cols;
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        col = i % cols;
        row  = i / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
    
}

@end
