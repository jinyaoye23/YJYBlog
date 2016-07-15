//
//  YJYComposeView.m
//  Weibo
//
//  Created by yaojinye on 16/7/10.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYComposeView.h"

@interface YJYComposeView ()

@property (nonatomic, weak)UILabel *placeholderLB;

@end


@implementation YJYComposeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeholderLB.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderLB.font = font;
    [self.placeholderLB sizeToFit];
}

-(UILabel *)placeholderLB{
    if (_placeholderLB == nil) {
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        _placeholderLB = label;
    }
    return _placeholderLB;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    
    self.placeholderLB.text = placeholder;
    
    [self.placeholderLB sizeToFit];

}

-(void)setHidePlaceholder:(BOOL)hidePlaceholder{
    _hidePlaceholder = hidePlaceholder;
    
    self.placeholderLB.hidden = hidePlaceholder;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.placeholderLB.x = 5;
    self.placeholderLB.y = 8;
    
}

@end
