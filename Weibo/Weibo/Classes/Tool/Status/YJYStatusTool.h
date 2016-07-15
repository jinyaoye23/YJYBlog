//
//  YJYStatusTool.h
//  Weibo
//
//  Created by yaojinye on 16/7/13.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJYStatusTool : NSObject
+(void)newStatusWithSinceId:(NSString *)maxId success:(void(^)(NSArray *statues))success failure:(void(^)(NSError *error))failure;

+(void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statues))success failure:(void(^)(NSError *error))failure;

@end
