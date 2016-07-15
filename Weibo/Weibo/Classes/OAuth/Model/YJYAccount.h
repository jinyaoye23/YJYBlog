//
//  YJYAccount.h
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "access_token" = "2.00lVvUPDecrWAD504a794fe5FcTC3B";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 2977414453;

 */
@interface YJYAccount : NSObject<NSCoding>
//获取数据的访问命令牌
@property (nonatomic, copy)NSString *access_token;
//账号的有效期
@property (nonatomic, copy)NSString *expires_in;

@property (nonatomic, copy)NSDate *expires_date;

@property (nonatomic, copy)NSString *remind_in;
//用户唯一标符
@property (nonatomic, copy)NSString *uid;

@property(nonatomic, copy)NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dic;

@end
