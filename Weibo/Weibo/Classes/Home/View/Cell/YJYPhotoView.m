//
//  YJYPhotoView.m
//  Weibo
//
//  Created by yaojinye on 16/7/8.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYPhotoView.h"
#import "UIImageView+WebCache.h"
#import "YJYPhoto.h"
@interface YJYPhotoView ()

@property (nonatomic, weak)UIImageView *gifView;

@end

@implementation YJYPhotoView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds = YES;
        UIImageView *gitView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        _gifView = gitView;
        [self addSubview:_gifView];
    }
    return self;
}

-(void)setPhoto:(YJYPhoto *)photo{
    _photo = photo;
    
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
