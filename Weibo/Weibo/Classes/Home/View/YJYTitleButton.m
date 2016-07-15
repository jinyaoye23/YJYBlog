//
//  YJYTitleButton.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYTitleButton.h"

@implementation YJYTitleButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.adjustsImageWhenHighlighted = NO;

        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];

        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];

        [self setBackgroundImage:[UIImage strechableImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

-(void)setFrame:(CGRect)frame{
    
    frame.size.width +=2;
    [super setFrame:frame];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    [super setBackgroundImage:image forState:state];
    [self sizeToFit];
}

@end
