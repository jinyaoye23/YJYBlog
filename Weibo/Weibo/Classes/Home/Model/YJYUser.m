//
//  YJYUser.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYUser.h"

@implementation YJYUser

-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}
@end
