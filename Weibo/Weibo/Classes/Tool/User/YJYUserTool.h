//
//  YJYUserTool.h
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJYUserResult;
@class YJYUser;

@interface YJYUserTool : NSObject

+(void)unreadWithSuccess:(void(^)(YJYUserResult *result))success failure:(void(^)(NSError *error))failure;

+(void)userInfroWithSuccess:(void(^)(YJYUser *user))success failure:(void(^)(NSError *error))failure;

@end
