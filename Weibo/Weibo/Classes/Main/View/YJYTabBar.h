//
//  YJYTabBar.h
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YJYTitleButton.h"

@class YJYTabBar;
@protocol YJYTaBarDelegate <UITabBarDelegate>

-(void)tabBarDidClickedPlusButton:(YJYTabBar *)tabBar;

@end

@interface YJYTabBar : UITabBar


@property (nonatomic, weak)id<YJYTaBarDelegate>delegate;


//-(void)addTarBarButtonWithItem:(UITabBarItem *)item;
@end
