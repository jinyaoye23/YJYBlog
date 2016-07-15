//
//  YJYNavigationController.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYNavigationController.h"
#import "YJYTabBar.h"

@interface YJYNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong)id popDelegate;

@end

@implementation YJYNavigationController

+(void)initialize{
    //
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *titleAtt = [NSMutableDictionary dictionary];
    titleAtt[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAtt forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _popDelegate=self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.delegate = nil;
    self.delegate = self;

}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"%@", self.viewControllers[0]);
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
//    NSLog(@"%s", __func__);
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    WBLog(@"%s", __func__);
    
    if (self.viewControllers.count !=0) {
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_more" highImage:@"navigationbar_more_highlighted" target:self action:@selector(backToPre)];
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" target:self action:@selector(backToRoot)];
    }
    
    
    
    
    [super pushViewController:viewController animated:YES];
}

-(void)backToPre{
    [self popViewControllerAnimated:YES];
}

-(void)backToRoot{
    [self popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
