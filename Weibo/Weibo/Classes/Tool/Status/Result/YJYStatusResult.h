//
//  YJYStatusResult.h
//  Weibo
//
//  Created by yaojinye on 16/7/13.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
/**
 created_at	string	微博创建时间
 id	int64	微博ID
 mid	int64	微博MID
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 */

@interface YJYStatusResult : NSObject<MJKeyValue>

@property (nonatomic, strong)NSArray *statuses;

@property (nonatomic, assign)int total_number;

@end
