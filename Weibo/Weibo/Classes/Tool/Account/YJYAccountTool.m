//
//  YJYAccountTool.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//专门处理账号的业务（账号的存储和读取）

#import "YJYAccountTool.h"
#import "YJYAccount.h"
#import "AFNetworking.h"
#import "YJYHttpTool.h"
#import "YJYAccoountParam.h"

#define YJYAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"accout.data"]
//类方法一般用静态变量代替成员属性
static YJYAccount *_account;

@implementation YJYAccountTool

+(void)saveAccount:(YJYAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:YJYAccountFileName];

}

+(YJYAccount *)account{
    if (!_account) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:YJYAccountFileName];
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    //过期时间 ＝ 当前时间＋有效时间
    WBLog(@"%@", _account.expires_date);
    return _account;
}

+(void)accessWithCode:(NSString *)code success:(void (^)())success failure:(void (^)())failure{
    
    YJYAccoountParam *param = [[YJYAccoountParam alloc]init];
    param.client_id = YJYClient_id;
    param.client_secret = YJYClient_secret;
    param.code = code;
    param.grant_type = @"authorization_code";
    param.redirect_uri = YJYRedirect_uri;
    
    [YJYHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param success:^(id responseObject) {
        
        YJYAccount *account = [YJYAccount accountWithDict:responseObject];
        //Save The Account Information
        [YJYAccountTool saveAccount:account];
        if (success) {
            success();
        }

    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"%@", error);
            failure(error);
        }
        
    }];
    

}

@end
