//
//  YJYBaseParm.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYBaseParm.h"
#import "YJYAccountTool.h"
#import "YJYAccount.h"

@implementation YJYBaseParm

+(instancetype)param{
    YJYBaseParm *param = [[self alloc]init];
    param.access_token = [YJYAccountTool account].access_token;
    return param;
}

@end
