//
//  YJYNewFeatureCell.h
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJYNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong)UIImage *image;

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

-(void)sendIndexthPath:(NSIndexPath *)indexPath pageCount:(NSInteger)pageCount;

@end
