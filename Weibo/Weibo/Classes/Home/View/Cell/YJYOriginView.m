//
//  YJYOriginView.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYOriginView.h"
#import "YJYStatus.h"
#import "YJYStatusFrame.h"
#import "YJYUser.h"
#import "YJYPhotosView.h"
#import "UIImageView+WebCache.h"

@interface YJYOriginView ()

@property (nonatomic, weak)YJYPhotosView *photoesV;

@property (nonatomic, weak)UIImageView *iconIV;

@property (nonatomic, weak)UIImageView *vipIV;

@property (nonatomic, weak)UILabel *nameLB;


@property (nonatomic, weak)UILabel *timeLB;


@property (nonatomic, weak)UILabel *sourceLB;


@property (nonatomic, weak)UILabel *textLB;


@end

@implementation YJYOriginView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupAllChildView];
        self.image = [UIImage strechableImage:@"timeline_card_top_background-1"];
        self.userInteractionEnabled = YES;
  
    }
    return self;
}

-(void)setupAllChildView{
    
    UIImageView *iconIV = [[UIImageView alloc]init];
    [self addSubview:iconIV];
    _iconIV = iconIV;
    
    
    UILabel *nameLB = [[UILabel alloc]init];
    nameLB.font = YJYNameFont;
    [self addSubview:nameLB];
    _nameLB = nameLB;
    
    UIImageView *vipIV = [[UIImageView alloc]init];
    [self addSubview:vipIV];
    _vipIV = vipIV;
    
    UILabel *timeLB = [[UILabel alloc]init];
    timeLB.font = YJYTimeFont;
    [self addSubview:timeLB];
    _timeLB = timeLB;
    
    UILabel *sourceLB = [[UILabel alloc]init];
    sourceLB.font = YJYSourceFont;
    [self addSubview:sourceLB];
    _sourceLB = sourceLB;
    
    UILabel *textLB = [[UILabel alloc]init];
    textLB.font = YJYTextFont;
    textLB.numberOfLines = 0;
    [self addSubview:textLB];
    _textLB = textLB;
    
    YJYPhotosView *photosV = [[YJYPhotosView alloc]init];
    [self addSubview:photosV];
    _photoesV = photosV;
    
    
}

-(void)setStatusFrame:(YJYStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    self.frame = statusFrame.originViewFrame;
    
    [self setupData];
    [self setupFrame];
    
}

-(void)setupData{
    YJYStatus *status = _statusFrame.status;
    [_iconIV sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if (status.user.mbtype) {
        _nameLB.textColor = [UIColor orangeColor];
    }
    _nameLB.text = status.user.name;
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
    _vipIV.image = [UIImage imageNamed:imageName];
    _textLB.text = status.text;
    _textLB.numberOfLines = 0;
    _timeLB.text = status.created_at;
    _sourceLB.text = status.source;

        
    _photoesV.pic_urls = status.pic_urls;

}
-(void)setupFrame{
    _iconIV.frame = _statusFrame.originIconFrame;
    _nameLB.frame = _statusFrame.originNameFrame;
    if (_statusFrame.status.user.vip) {
        _vipIV.hidden = NO;
        _vipIV.frame = _statusFrame.originViptFrame;
    }else{
        _vipIV.hidden = YES;
    }
    _timeLB.frame = _statusFrame.originTimeFrame;
    _sourceLB.frame = _statusFrame.originSourceFrame;
    _textLB.frame = _statusFrame.originTextFrame;

    _photoesV.frame = _statusFrame.originPhotosFrame;
    
}

@end
