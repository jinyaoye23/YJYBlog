//
//  YJYReweetStatus.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYReweetStatus.h"
#import "YJYPhoto.h"

@implementation YJYReweetStatus

+(NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls":[YJYPhoto class]};
}

@end
