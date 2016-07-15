//
//  YJYPhotosView.m
//  Weibo
//
//  Created by yaojinye on 16/7/8.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYPhotosView.h"
#import "YJYPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "YJYPhotoView.h"

@implementation YJYPhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
       
        [self setupAllChildView];
        
    }
    return self;
}

-(void)setupAllChildView{
    for (int i=0; i<9; i++) {
        YJYPhotoView *imgView = [[YJYPhotoView alloc]init];
        
        imgView.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imgView addGestureRecognizer:tap];
        
        [self addSubview:imgView];
    }
}

-(void)tap:(UITapGestureRecognizer *)tap{
    UIImageView *tapView = tap.view;
    
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (YJYPhoto *photo in _pic_urls) {
        MJPhoto *p = [[MJPhoto alloc]init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
//        NSLog(@"url:%@", urlStr);
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:urlStr];
//        p.url = photo.thumbnail_pic;
        p.index =i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.photos = arrM;
    browser.currentPhotoIndex = tapView.tag;
    [browser show];
    //http://ww1.sinaimg.cn/thumbnail/885b3f21jw1f5n1h0riggj20hs0vljte.jpg
}

-(void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    
    int count = self.subviews.count;
    for (int i=0; i<count; i++) {
        
        YJYPhotoView *imgView = self.subviews[i];
        if (i < _pic_urls.count) {
            
            imgView.hidden = NO;
            YJYPhoto *photo = _pic_urls[i];
            imgView.photo = photo;
            
            
        }else{
            imgView.hidden = YES;
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count == 4? 2 : 3;
    for (int i = 0; i < _pic_urls.count; i++) {
        
        col = i % cols;
        rol = i / cols;
        
        UIImageView *imgView = self.subviews[i];
        
        x = col * (w + margin);
        y = rol * (h + margin);
        
        imgView.frame = CGRectMake(x, y, w, h);
        
        
    }
    
}

@end
