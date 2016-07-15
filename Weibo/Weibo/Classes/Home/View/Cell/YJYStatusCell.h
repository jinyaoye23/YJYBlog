//
//  YJYStatusCell.h
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJYStatusFrame;

@interface YJYStatusCell : UITableViewCell

@property (nonatomic, strong)YJYStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
