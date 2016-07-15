//
//  YJYStatusDataTool.h
//  Weibo
//
//  Created by yaojinye on 16/7/11.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YJYStatusParam;

@interface YJYStatusDataTool : NSObject

+(NSArray *)statusesWithParams:(NSDictionary *)param;

+(NSArray *)statusesWithStatuses:(YJYStatusParam *)param;



+(void)saveStatuses:(NSArray *)statuses;

@end
