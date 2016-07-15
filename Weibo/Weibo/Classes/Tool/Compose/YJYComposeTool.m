//
//  YJYCompostTool.m
//  Weibo
//
//  Created by yaojinye on 16/7/11.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYComposeTool.h"
#import "YJYHttpTool.h"
#import "YJYComposeParam.h"
#import "MJExtension.h"
#import "YJYAccount.h"
#import "YJYAccountTool.h"
#import "AFNetworking.h"


@implementation YJYComposeTool

+(void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    YJYComposeParam *param = [YJYComposeParam param];
    param.status = status;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.mj_keyValues success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];


//    [YJYHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.mj_keyValues success:^(id responseObject) {
//        if (success) {
//            success();
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    
    
}

@end
