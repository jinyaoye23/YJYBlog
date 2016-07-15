//
//  YJYUserResult.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYUserResult.h"

@implementation YJYUserResult

-(int)messageCount{
    return _cmt + _dm +_mention_cmt + _mention_status;
}

-(int)totalMessageCount{
    return self.messageCount + _status + _follower;
}

@end
