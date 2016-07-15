//
//  YJYPopViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYPopViewController.h"

@interface YJYPopViewController ()

@property (nonatomic, strong) NSArray *datas;


@end

@implementation YJYPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = @[@"好友圈",@"我的微博",@"周边微博"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = _datas[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];

    return cell;
}



@end
