//
//  YJYMessageViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYMessageViewController.h"

@interface YJYMessageViewController ()

@end

@implementation YJYMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *chat = [[UIBarButtonItem alloc]initWithTitle:@"发起聊天" style:UIBarButtonItemStyleBordered target:self action:@selector(chat)];
    

    
    
    self.navigationItem.rightBarButtonItem = chat;
}

-(void)chat{
    WBLog(@"%s", __func__);
    
}

@end
