//
//  YJYTabBarButton.m
//  Weibo
//
//  Created by yaojinye on 16/7/9.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYTabBarButton.h"

@implementation YJYTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
    }
    return self;
}

@end
