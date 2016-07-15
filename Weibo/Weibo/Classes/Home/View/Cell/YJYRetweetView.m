//
//  YJYRetweetView.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYRetweetView.h"
#import "YJYStatus.h"
#import "YJYUser.h"
#import "YJYStatusFrame.h"
#import "YJYReweetStatus.h"
#import "YJYPhotosView.h"


@interface YJYRetweetView ()

@property (nonatomic, weak)YJYPhotosView *photosV;

@property (nonatomic, weak)UILabel *nameLB;
@property (nonatomic, weak)UILabel *textLB;

@end

@implementation YJYRetweetView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
        
        self.image = [UIImage imageNamed:@"timeline_retweet_background_highlighted"];
        self.userInteractionEnabled = YES;
        

    }
    return self;
}
-(void)setupAllChildView{
        
    UILabel *nameLB = [[UILabel alloc]init];
    nameLB.font = YJYNameFont;
    [self addSubview:nameLB];
    _nameLB = nameLB;

    
    UILabel *textLB = [[UILabel alloc]init];
    textLB.font = YJYTextFont;
    textLB.numberOfLines = 0;
    [self addSubview:textLB];
    _textLB = textLB;
    
    YJYPhotosView *photosV = [[YJYPhotosView alloc]init];
    [self addSubview:photosV];
    _photosV = photosV;

}

-(void)setStatusFrame:(YJYStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    YJYStatus *s = statusFrame.status;
    
    self.frame = statusFrame.retweetViewFrame;
    
//    _nameLB.text = [NSString stringWithFormat:@"@%@", s.retweeted_status.user.name];
    _nameLB.text = s.retweetedName;
    _nameLB.textColor = [UIColor blueColor];
    _nameLB.frame = statusFrame.retweetNameFrame;
    
    _textLB.text = s.retweeted_status.text;
    _textLB.frame = statusFrame.retweetextFrame;
    
    _photosV.frame = statusFrame.retweetPhotosFrame;

        
    _photosV.pic_urls = s.retweeted_status.pic_urls;

}


@end
