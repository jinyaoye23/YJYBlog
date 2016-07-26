//
//  YJYStatus.h
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJYUser;

#import "MJExtension.h"
/*
 

 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
  geo	object	地理信息字段 详细

 */
@interface YJYStatus : NSObject<MJKeyValue>
//微博创建时间
@property (nonatomic, copy)NSString *created_at;

@property (nonatomic, assign)NSUInteger ID;
//字符串型的微博ID
@property (nonatomic, copy)NSString *idstr;
//微博信息内容
@property (nonatomic, copy)NSString *text;

@property (nonatomic,strong)YJYStatus *retweeted_status;

@property (nonatomic, copy)NSString *retweetedName;
//微博来源
@property (nonatomic, copy)NSString *source;

@property (nonatomic, assign)int reposts_count;//转发数

@property (nonatomic, assign)int comments_count;//评论数

@property (nonatomic, assign)int attitudes_count;//表态数

@property (nonatomic, strong)NSArray *pic_urls;//

@property (nonatomic, strong)YJYUser *user;

@end
