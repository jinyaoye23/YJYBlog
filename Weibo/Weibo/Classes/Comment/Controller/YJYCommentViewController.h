//
//  YJYCommentViewController.h
//  Weibo
//
//  Created by yaojinye on 16/7/21.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYBaseVC.h"
@class YJYCommentParam;
@class YJYStatus;
@interface YJYCommentViewController : YJYBaseVC

@property (nonatomic, strong)YJYStatus *status;
@property (nonatomic, retain)YJYCommentParam *commentParam;

@end
