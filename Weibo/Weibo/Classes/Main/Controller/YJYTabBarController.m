//
//  YJYTabBarController.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYTabBarController.h"

#import "YJYHomeViewController.h"
#import "YJYMessageViewController.h"
#import "YJYDiscoverViewController.h"
#import "YJYProfileViewController.h"
#import "YJYComposeViewController.h"

#import "YJYNavigationController.h"
#import "YJYTabBar.h"
#import "UIImage+Image.h"
#import <objc/message.h>
#import "YJYUserTool.h"
#import "YJYUserResult.h"
#import "YJYStatus.h"



@interface YJYTabBarController ()<YJYTaBarDelegate>
@property (nonatomic, weak)YJYHomeViewController *home;
@property (nonatomic, weak)YJYMessageViewController *message;
@property (nonatomic, weak)YJYProfileViewController *profile;
@property (nonatomic, weak)YJYTabBar *customTarBar;

@end

@implementation YJYTabBarController
//什么时候调用：程序一启动的时候就会把所有的类加载进内容
//作用：加载类的时候调用
//+(void)load{
//    NSLog(@"%s", __func__);
//}

//什么时候调用：当第一次使用这个类的时候调用
//作用：初始化类
+(void)initialize{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:dic forState:UIControlStateSelected];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupTabBar];
    [self setupAllChildViewController];
    
//    objc_msgSend(self, @selector(setTabBar:), tabBar);
//    NSLog(@"%@", self.tabBar);
//    self.tabBar = tabBar;
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
    
    
    
}

-(void)setupTabBar{
    
    YJYTabBar *tabBar = [[YJYTabBar alloc]init];
    tabBar.frame = self.tabBar.frame;
//    NSLog(@"%@", tabBar.subviews);
        [self setValue:tabBar forKey:@"tabBar"];
//    [self.tabBar addSubview:tabBar];
//    NSLog(@"%@", tabBar.subviews);
    
    _customTarBar = tabBar;

    
}


-(void)requestUnread{
    
//    NSLog(@"%s", __func__);
    [YJYUserTool unreadWithSuccess:^(YJYUserResult *result) {
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalMessageCount;
        
    } failure:^(NSError *error) {
        
    }];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}

-(void)setupAllChildViewController{
    YJYHomeViewController *home = [[YJYHomeViewController alloc]init];
    [self setupOneChildController:home image:[UIImage imageNamed:@"tabbar_home"] selectImage:[UIImage imageWithOriginName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;

    YJYMessageViewController *message = [[YJYMessageViewController alloc]init];
    [self setupOneChildController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectImage:[UIImage imageWithOriginName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;

    YJYDiscoverViewController *discover = [[YJYDiscoverViewController alloc]init];
    [self setupOneChildController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectImage:[UIImage imageWithOriginName:@"tabbar_discover_selected"] title:@"发现"];


    YJYProfileViewController *profile = [[YJYProfileViewController alloc]init];
    [self setupOneChildController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectImage:[UIImage imageWithOriginName:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;

    
}
-(void)setupOneChildController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectImage;
    
    YJYNavigationController *nv = [[YJYNavigationController alloc]initWithRootViewController:vc];
    vc.title = title;
//    [self.customTarBar addTarBarButtonWithItem:vc.tabBarItem];
    [self addChildViewController:nv];
}

-(void)tabBarDidClickedPlusButton:(YJYTabBar *)tabBar{
    
    YJYComposeViewController *composeVC =[[YJYComposeViewController alloc]init];
    YJYNavigationController *nav = [[YJYNavigationController alloc]initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];

}

@end
