//
//  YJYNewFeatureController.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYNewFeatureController.h"

#import "YJYNewFeatureCell.h"

#define kNewFeatureCount 4
static NSString *ID = @"cell";


@interface YJYNewFeatureController ()

@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation YJYNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout] ;
}

//self.view != self.collectionView;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self setupPageController];
}

-(void)setupPageController{
    
    UIPageControl *pageContr = [[UIPageControl alloc]init];
    pageContr.center = CGPointMake(self.view.center.x, self.view.height);
    pageContr.numberOfPages = kNewFeatureCount;
    pageContr.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageContr.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl = pageContr;
    [self.view addSubview:_pageControl];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.width + 0.5;
    _pageControl.currentPage = page;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    YJYNewFeatureCell *cell = [YJYNewFeatureCell cellWithCollectionView:collectionView indexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    cell.backgroundColor = [UIColor greenColor];
    [cell sendIndexthPath:indexPath pageCount:kNewFeatureCount];
    return cell;
}

@end
