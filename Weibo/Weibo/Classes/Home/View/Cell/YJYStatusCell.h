//
//  YJYStatusCell.h
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJYStatusFrame;
@class YJYStatusToolBar;
@interface YJYStatusCell : UITableViewCell

@property (nonatomic, strong)YJYStatusFrame *statusFrame;
@property (nonatomic, strong)YJYStatusToolBar *statusTB;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
