//
//  YJYUserResult.h
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 返回值字段	字段类型	字段说明
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 */
@interface YJYUserResult : NSObject

@property (nonatomic, assign)int status;
@property (nonatomic, assign)int follower;
@property (nonatomic, assign)int cmt;
@property (nonatomic, assign)int dm;
@property (nonatomic, assign)int mention_status;
@property (nonatomic, assign)int mention_cmt;

-(int)messageCount;
-(int)totalMessageCount;


@end
