//
//  YJYAccountTool.h
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YJYAccount;
@interface YJYAccountTool : NSObject
+(void)saveAccount:(YJYAccount *)account;

+(YJYAccount *)account;

+(void)accessWithCode:(NSString *)code success:(void(^)())success failure:(void(^)())failure;

@end
