//
//  YJYStatusCell.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYStatusCell.h"
#import "YJYStatus.h"

#import "YJYOriginView.h"
#import "YJYRetweetView.h"
#import "YJYStatusToolBar.h"
#import "YJYStatusFrame.h"

@interface YJYStatusCell ()

@property (nonatomic, weak)YJYOriginView *origin;
@property (nonatomic, weak)YJYRetweetView *retweet;
@property (nonatomic, weak)YJYStatusToolBar *toolBar;

@end


@implementation YJYStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    id  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    return cell;

}

-(void)setupAllChildView{
    
    YJYOriginView *origin = [[YJYOriginView alloc]init];
    [self.contentView addSubview:origin];
    _origin = origin;
    
    YJYRetweetView *retweet = [[YJYRetweetView alloc]init];
    [self.contentView addSubview:retweet];
    _retweet = retweet;
    
    YJYStatusToolBar *toolBar = [[YJYStatusToolBar alloc]init];
    [self.contentView addSubview:toolBar];
    _toolBar = toolBar;
    
    
}

-(void)setStatusFrame:(YJYStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    _origin.frame = statusFrame.originViewFrame;
    _origin.statusFrame = statusFrame;
    if (statusFrame.status.retweeted_status) {
        
        _retweet.frame = statusFrame.retweetViewFrame;
        _retweet.statusFrame = statusFrame;
        _retweet.hidden = NO;
    }else{
        _retweet.hidden = YES;
    }
    
    _toolBar.frame = statusFrame.toolBarFrame;
    _toolBar.status = statusFrame.status;

    
}




@end
