//
//  YJYStatusTool.m
//  Weibo
//
//  Created by yaojinye on 16/7/13.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYStatusTool.h"
#import "YJYStatusParam.h"
#import "AFNetworking.h"
#import "YJYAccountTool.h"
#import "YJYAccount.h"
#import "MJExtension.h"
#import "YJYStatus.h"
#import "YJYStatusResult.h"

@implementation YJYStatusTool


+(void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
    YJYStatusParam * param = [[YJYStatusParam alloc]init];
    param.since_id = sinceId;
    param.access_token = [YJYAccountTool account].access_token;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        YJYStatusResult *result = [YJYStatusResult mj_objectWithKeyValues:responseObject];
        
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}

+(void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    YJYStatusParam * param = [[YJYStatusParam alloc]init];
    param.max_id = maxId;
    param.access_token = [YJYAccountTool account].access_token;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        YJYStatusResult *result = [YJYStatusResult mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

    
    
}

@end
