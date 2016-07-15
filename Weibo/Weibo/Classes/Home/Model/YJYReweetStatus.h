//
//  YJYReweetStatus.h
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJYUser;
#import "MJExtension.h"
@interface YJYReweetStatus : NSObject<MJKeyValue>

@property (nonatomic, copy)NSString *created_at;
//字符串型的微博ID
@property (nonatomic, copy)NSString *idstr;
//微博信息内容
@property (nonatomic, copy)NSString *text;
//微博来源
@property (nonatomic, copy)NSString *source;

@property (nonatomic, assign)int reposts_count;//转发数
@property (nonatomic, assign)int comments_count;//评论数
@property (nonatomic, assign)int attitudes_count;//表态数
@property (nonatomic, strong)NSArray *pic_urls;//
@property (nonatomic, strong)YJYUser *user;



@end
