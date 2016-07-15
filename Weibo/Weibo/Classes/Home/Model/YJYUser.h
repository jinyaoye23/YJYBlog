//
//  YJYUser.h
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJYUser : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSURL *profile_image_url;
@property (nonatomic, assign)int mbtype;
@property (nonatomic, assign)int mbrank;
@property (nonatomic, assign, getter=isVip)BOOL vip;

@end
