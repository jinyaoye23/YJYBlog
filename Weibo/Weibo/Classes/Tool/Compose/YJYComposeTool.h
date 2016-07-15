//
//  YJYCompostTool.h
//  Weibo
//
//  Created by yaojinye on 16/7/11.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJYComposeTool : NSObject

+(void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
