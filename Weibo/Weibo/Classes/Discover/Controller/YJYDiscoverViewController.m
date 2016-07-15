//
//  YJYDiscoverViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYDiscoverViewController.h"
#import "YJYSearchBar.h"

@interface YJYDiscoverViewController ()

@end

@implementation YJYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJYSearchBar *searchBar = [[YJYSearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    searchBar.placeholder = @"大家都在搜";
    
    
    self.navigationItem.titleView = searchBar;
    
    
}


@end
