//
//  YJYStatusFrame.h
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YJYStatus;
@interface YJYStatusFrame : NSObject

@property (nonatomic, strong)YJYStatus *status;

/**     ***OriginViewFrame***    **/
@property (nonatomic, assign)CGRect originViewFrame;
@property (nonatomic, assign)CGRect originIconFrame;
@property (nonatomic, assign)CGRect originNameFrame;
@property (nonatomic, assign)CGRect originViptFrame;
@property (nonatomic, assign)CGRect originTimeFrame;
@property (nonatomic, assign)CGRect originSourceFrame;
@property (nonatomic, assign)CGRect originTextFrame;
@property (nonatomic, assign)CGRect originPhotosFrame;

/**     ***RetweetViewFrame***    **/
@property (nonatomic, assign)CGRect retweetViewFrame;
@property (nonatomic, assign)CGRect retweetNameFrame;
@property (nonatomic, assign)CGRect retweetextFrame;
@property (nonatomic, assign)CGRect retweetPhotosFrame;

@property (nonatomic, assign)CGRect toolBarFrame;

@property (nonatomic, assign)CGFloat cellHeight;

@end
