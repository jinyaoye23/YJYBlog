//
//  YJYAccoountParam.h
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 params[@"client_id"] = YJYClient_id;
 params[@"client_secret"] = YJYClient_secret;
 params[@"grant_type"] = @"authorization_code";
 params[@"code"] = code;
 params[@"redirect_uri"] = YJYRedirect_uri;

 */
@interface YJYAccoountParam : NSObject

@property (nonatomic, strong)NSString *client_id;
@property (nonatomic, strong)NSString *client_secret;
@property (nonatomic, strong)NSString *grant_type;
@property (nonatomic, strong)NSString *code;
@property (nonatomic, strong)NSString *redirect_uri;

@end
