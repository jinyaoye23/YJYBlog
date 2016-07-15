//
//  YJYNewFeatureCell.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYNewFeatureCell.h"
#import "YJYTabBarController.h"
static NSString *ID = @"cell";
static UICollectionView *_collectionView = nil;

@interface YJYNewFeatureCell ()

@property (nonatomic,weak)UIImageView *imageView;

@property (nonatomic, weak)UIButton *shareBtn;
@property (nonatomic, weak)UIButton *starBtn;

@end

@implementation YJYNewFeatureCell

-(UIImageView *)imageView{
    if (!_imageView) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        _imageView = imageView;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [shareBtn sizeToFit];
        [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        shareBtn.center = CGPointMake(self.width * 0.5, self.height * 0.75);
        [shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn = shareBtn;
        [self addSubview:_shareBtn];
    }
    return _shareBtn;
}

-(UIButton *)starBtn{
    if (!_starBtn) {
        UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [starBtn setTitle:@"进入微博" forState:UIControlStateNormal];
        [starBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [starBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [starBtn sizeToFit];
        starBtn.center = CGPointMake(self.width * 0.5, self.height * 0.85);
        [starBtn addTarget:self action:@selector(starBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _starBtn = starBtn;
        [self addSubview:_starBtn];
    }
    return _starBtn;
}

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    
    if (_collectionView == nil) {
        _collectionView = collectionView;
        [collectionView registerClass:[self class] forCellWithReuseIdentifier:ID];
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
}

-(void)sendIndexthPath:(NSIndexPath *)indexPath pageCount:(NSInteger)pageCount{
    if (indexPath.row == pageCount - 1) {
        [self shareBtn];
        [self starBtn];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;

    
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = _image;

}

-(void)shareBtnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
}

-(void)starBtnClicked{
    YJYTabBarController *tabBar = [[YJYTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
}

@end
