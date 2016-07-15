//
//  YJYStatusResult.m
//  Weibo
//
//  Created by yaojinye on 16/7/13.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYStatusResult.h"
#import "YJYStatus.h"

@implementation YJYStatusResult

+(NSDictionary *)mj_objectClassInArray{
    return @{@"statuses":[YJYStatus class]};
}

@end
