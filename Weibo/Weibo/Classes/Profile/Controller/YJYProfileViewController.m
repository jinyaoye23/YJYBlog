//
//  YJYProfileViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYProfileViewController.h"

@interface YJYProfileViewController ()

@end

@implementation YJYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *chat = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    
    
    
    self.navigationItem.rightBarButtonItem= chat;
    
    
}

-(void)setting{
    
}

@end
