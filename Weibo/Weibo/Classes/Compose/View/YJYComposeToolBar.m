//
//  YJYComposeToolBar.m
//  Weibo
//
//  Created by yaojinye on 16/7/10.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYComposeToolBar.h"



@implementation YJYComposeToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
    }
    return self;
}

-(void)setupAllChildView{
    [self setupButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_selected"] target:self action:@selector(btnClicked:) type:YJYComposeToolBarButtonTypePicture];
    [self setupButtonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(btnClicked:) type:YJYComposeToolBarButtonTypeTrend];
    [self setupButtonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_selected"] target:self action:@selector(btnClicked:) type:YJYComposeToolBarButtonTypeMentionType];
    [self setupButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_selected"] target:self action:@selector(btnClicked:) type:YJYComposeToolBarButtonTypePicture];
    [self setupButtonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(btnClicked:) type:YJYComposeToolBarButtonTypeEmoticon];
    
}

-(void)btnClicked:(UIButton *)btn{
    NSLog(@"btn------");
    if ([_delegate respondsToSelector:@selector(composeToolBar:btnClickedIndex:)]) {
        [_delegate composeToolBar:self btnClickedIndex:btn.tag];
    }
}
-(void)setupButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action type:(YJYComposeToolBarButtonType)type{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = type;
    
    [self addSubview:btn];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        x = w * i;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
}

@end
