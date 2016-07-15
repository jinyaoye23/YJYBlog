//
//  YJYHttpTool.h
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//处理网络请求

#import <Foundation/Foundation.h>

@interface YJYHttpTool : NSObject

/**
 发
 *@param URLString   请求的基本URL
 *@param parameters  请求的参数字典
 *@param success     请求成功的回调
 *@param failure     请求失败的回
 */
+(void)GET:(NSString *)URLString
                    parameters:(id)parameters
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;
/**
 *@param URLString   请求的基本URL
 *@param parameters  请求的参数字典
 *@param success     请求成功的回调
 *@param failure     请求失败的回调
 */
+(void)POST:(NSString *)URLString
                parameters:(id)parameters
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure;

@end
