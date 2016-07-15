//
//  AppDelegate.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

//    makeKeyAndVisible的底层实现
//    1.application.keyWindow = self.window;
//    2.self.window.hidden = NO;


#import "AppDelegate.h"

#import "YJYOAuthViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "YJYAccountTool.h"
#import "YJYRootTool.h"
#import "UIImageView+WebCache.h"

//偏好设置存储的好处
//1.不需要关心文件名
//2.快速进行键值对的存储
@interface AppDelegate ()

@property (nonatomic, retain)AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    //创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    if ([YJYAccountTool account]) {
        
        [YJYRootTool chooseRootViewController:self.window];
        
    }else{
        YJYOAuthViewController *oauthVc = [[YJYOAuthViewController alloc]init];
        
        self.window.rootViewController = oauthVc;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

//接受到内存警告时调用
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"情非得已.mp3" withExtension:nil];
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [player prepareToPlay];
    player.numberOfLoops = -1;
    [player play];
    _player = player;
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //开启一个后台任务
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        //当后台任务结束时调用
        [application endBackgroundTask:ID];
    
    }];
    //如何提高后台任务的优先级，

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [_player stop];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
