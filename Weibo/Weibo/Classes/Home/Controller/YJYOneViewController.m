//
//  YJYOneViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYOneViewController.h"
#import "YJYTowViewController.h"

@interface YJYOneViewController ()

@end

@implementation YJYOneViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    WBLog(@"%s", __func__);
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    


    
    
}
- (IBAction)goToNextVCBtnClicked:(id)sender {
    YJYTowViewController *tVc = [[YJYTowViewController alloc]init];
    [self.navigationController pushViewController:tVc animated:YES];
}

@end
