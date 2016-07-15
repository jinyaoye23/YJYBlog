//
//  YJYRootTool.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYRootTool.h"
#import "YJYTabBarController.h"
#import "YJYNewFeatureController.h"

#define WBVersionKey @"version"


@implementation YJYRootTool

+(void)chooseRootViewController:(UIWindow *)window{
    //获取当前版本好
    NSString *currentVersion =  [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //获取上一个版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:WBVersionKey];
    //判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) {
        UITabBarController *tabBarVc = [[YJYTabBarController alloc]init];
        window.rootViewController = tabBarVc;
    }else{
        //如果有新版，进入新特性界面
        YJYNewFeatureController *newF = [[YJYNewFeatureController alloc]init];
        window.rootViewController = newF;
    }
    
    //保存当前版本，用偏好设置
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:WBVersionKey];
    
    
}


@end
