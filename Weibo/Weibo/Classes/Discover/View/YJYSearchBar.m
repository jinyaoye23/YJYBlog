//
//  YJYSearchBar.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYSearchBar.h"

@implementation YJYSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.font = [UIFont systemFontOfSize:13];
        self.background = [UIImage strechableImage:@"searchbar_textfield_background"];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
//        imgView.contentMode = UIViewContentModeCenter;

        self.leftView = imgView;
        self.leftViewMode = UITextFieldViewModeAlways;
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
