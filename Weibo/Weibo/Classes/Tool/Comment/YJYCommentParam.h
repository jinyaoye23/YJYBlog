//
//  YJYCommentParam.h
//  Weibo
//
//  Created by yaojinye on 16/7/21.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYBaseParm.h"
/**
 comment	true	string	评论内容，必须做URLencode，内容不超过140个汉字。
 id	true	int64	需要评论的微博ID。
 */

@interface YJYCommentParam : YJYBaseParm

@property (nonatomic, copy)NSString *comment;
@property (nonatomic, assign)NSUInteger ID;

@end
