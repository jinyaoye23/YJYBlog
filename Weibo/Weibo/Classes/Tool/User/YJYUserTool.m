//
//  YJYUserTool.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYUserTool.h"

#import "YJYHttpTool.h"
#import "YJYUserParam.h"
#import "YJYUserResult.h"
#import "YJYUser.h"

#import "YJYAccountTool.h"
#import "YJYAccount.h"
#import "MJExtension.h"

@implementation YJYUserTool

+(void)userInfroWithSuccess:(void(^)(YJYUser *user))success failure:(void(^)(NSError *error))failure{
    
    YJYUserParam *param = [YJYUserParam param];
    param.uid = [YJYAccountTool account].uid;
    
    [YJYHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.mj_keyValues success:^(id responseObject) {
        YJYUser *user = [YJYUser mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        
    }];
    
}
+(void)unreadWithSuccess:(void (^)(YJYUserResult *))success failure:(void (^)(NSError *))failure{
    YJYUserParam *param = [YJYUserParam param];
    param.uid = [YJYAccountTool account].uid;
    
    
    [YJYHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.mj_keyValues success:^(id responseObject) {
        YJYUserResult *result = [YJYUserResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
