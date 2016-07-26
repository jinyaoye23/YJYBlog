//-[NSObject(NSObject) doesNotRecognizeSelector:]
//  YJYHomeViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//
//https://api.weibo.com/2/statuses/friends_timeline.json?access_token=2.00lVvUPDecrWAD504a794fe5FcTC3B

#import "YJYHomeViewController.h"

#import "YJYTitleButton.h"
#import "YJYPopView.h"

#import "YJYPopViewController.h"
#import "YJYOneViewController.h"
#import "AFNetworking.h"
#import "YJYAccount.h"
#import "YJYAccountTool.h"
#import "YJYHttpTool.h"
#import "YJYStatusTool.h"
#import "YJYStatusResult.h"
#import "YJYUserTool.h"
#import "YJYStatusDataTool.h"
#import "YJYStatusParam.h"


#import "YJYStatusCell.h"

#import "YJYStatus.h"
#import "YJYUser.h"
#import "YJYPhoto.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "YJYStatusFrame.h"
#import "YJYStatusToolBar.h"
#import "YJYCommentViewController.h"
#import "YJYNavigationController.h"

@interface YJYHomeViewController ()<YJYStatusToolBarDelegate>

@property (nonatomic, weak)YJYTitleButton *titleButton;
@property (nonatomic, retain)YJYPopView *popView;
@property (nonatomic, retain)YJYPopViewController *popVc;
/**
    ViewModel:YJYStatusFrame
 */
@property (nonatomic, strong)NSMutableArray *statusFrame;

@end

@implementation YJYHomeViewController

-(NSMutableArray *)statusFrame{
    if (!_statusFrame) {
        NSMutableArray *arr = [NSMutableArray array];
        _statusFrame = arr;
    }
    return _statusFrame;
}

-(YJYPopViewController *)popVc{
    if (!_popVc) {
        YJYPopViewController *popVc = [[YJYPopViewController alloc]init];
        _popVc = popVc;
    }
    return _popVc;
}

-(YJYPopView *)popView{
    if (!_popView) {
        YJYPopView *popView = [YJYPopView createPopView];
        _popView = popView;
    }
    return _popView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self setupNavigationBar];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    [self.tableView.mj_footer beginRefreshing];
    [YJYUserTool userInfroWithSuccess:^(YJYUser *user) {
        
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
//        NSLog(@"name:%@", user.name);

    } failure:^(NSError *error) {
        
    }];
    
}

-(void)loadMoreStatus{
    
    NSString *maxIdStr = nil;
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.statusFrame.count) {

        YJYStatus *status = [[self.statusFrame lastObject] status];;
        long long maxId=[status.idstr longLongValue]-1;
        YJYStatusParam *param = [[YJYStatusParam alloc]init];
        param.max_id =status.idstr;
        maxIdStr = [NSString stringWithFormat:@"%lld", maxId];
        dic = param.mj_keyValues;
    }

    NSArray *statuses = [YJYStatusDataTool statusesWithParams:dic];
    if (statuses.count) {
        NSArray *newStatuses = [YJYStatus mj_objectArrayWithKeyValuesArray:statuses];
        
        NSMutableArray *statuesFrames = [NSMutableArray array];
        for (YJYStatus *st in newStatuses) {
            YJYStatusFrame *statusFra = [[YJYStatusFrame alloc]init];
            statusFra.status = st;
            [statuesFrames addObject:statusFra];
        }
        
        [self.statusFrame addObjectsFromArray:statuesFrames];
        [self.tableView reloadData];

    }else{
        
        [YJYStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statues) {
            
            [self.tableView.mj_footer endRefreshing];
            
            [YJYStatusDataTool saveStatuses:statues];
            
            NSMutableArray *statuesFrames = [NSMutableArray array];
            for (YJYStatus *st in statues) {
                YJYStatusFrame *statusFra = [[YJYStatusFrame alloc]init];
                statusFra.status = st;
                [statuesFrames addObject:statusFra];
            }
            
            [self.statusFrame addObjectsFromArray:statuesFrames];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            
        }];    
    }
    
}
-(void)loadNewStatus{
    
    NSString *sinceId = nil;
    NSDictionary *dic = [NSDictionary dictionary];
    YJYStatusParam *param = [[YJYStatusParam alloc]init];
    if (self.statusFrame.count) {
        
        YJYStatus *status = [self.statusFrame[0] status];
        param.since_id =status.idstr;
        sinceId = status.idstr;
        dic = status.mj_keyValues;
        
    }
    
    NSArray *Statuses = [YJYStatusDataTool statusesWithStatuses:param];
    if (Statuses.count) {
        
        NSMutableArray *statuesFrames = [NSMutableArray array];
        NSArray *newStatuses = [YJYStatus mj_objectArrayWithKeyValuesArray:Statuses];
        
        for (YJYStatus *st in newStatuses) {
            YJYStatusFrame *statusFra = [[YJYStatusFrame alloc]init];
            statusFra.status = st;
            WBLog(@"----%lu", (unsigned long)st.ID);
            [statuesFrames addObject:statusFra];
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStatuses.count)];
        [self.statusFrame insertObjects:statuesFrames atIndexes:indexSet];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];

        
    }else{
        
        [YJYStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statues) {
            [self showNewStatusCount:(int)statues.count];
            
            [YJYStatusDataTool saveStatuses:statues];
            
            [self.tableView.mj_header endRefreshing];
            NSMutableArray *statuesFrames = [NSMutableArray array];
            for (YJYStatus *st in statues) {
                YJYStatusFrame *statusFra = [[YJYStatusFrame alloc]init];
                statusFra.status = st;
                WBLog(@"=====%lu", (unsigned long)st.ID);

                [statuesFrames addObject:statusFra];
            }
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statues.count)];
            [self.statusFrame insertObjects:statuesFrames atIndexes:indexSet];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            
        }];
    }
}
-(void)showNewStatusCount:(int)count{
    if (count == 0) return;
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
   
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text = [NSString stringWithFormat:@"最新微博数%d", count];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 delay:2 options:
         UIViewAnimationOptionCurveLinear animations:^{
             
             label.transform = CGAffineTransformIdentity;
         } completion:^(BOOL finished) {
             [label removeFromSuperview];
             
         }];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusFrame.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YJYStatusCell *cell = [YJYStatusCell cellWithTableView:tableView];
    YJYStatusFrame *statusFrame = self.statusFrame[indexPath.row];
    cell.statusFrame = statusFrame;
    NSLog(@"--%lu---", statusFrame.status.ID);
    cell.statusTB.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YJYStatusFrame *statusFrame = self.statusFrame[indexPath.row];
    NSLog(@"--%lu---", statusFrame.status.ID);

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJYStatusFrame *statusFrame = self.statusFrame[indexPath.row];
    return statusFrame.cellHeight;
}

-(void)setupNavigationBar{
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    YJYTitleButton *titleBtn = [YJYTitleButton buttonWithType:UIButtonTypeCustom];
    NSString *title = [YJYAccountTool account].name?:@"首页";
    [titleBtn setTitle:title forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.titleButton = titleBtn;
    self.navigationItem.titleView = self.titleButton;
    
    

    
    
}
-(void)titleBtnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;

    CGFloat x = (self.view.width - 200) * 0.5;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - 9;
    
    self.popView.contentView = self.popVc.view;
    
    [self.popView showInRect:CGRectMake(x, y, 200, 200)];
}

-(void)pop{
    YJYOneViewController *oVc =[[YJYOneViewController alloc]init];
    oVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:oVc animated:YES];
}

-(void)statusToorBarButonClicked:(YJYStatusToolBarButtonType)type status:(YJYStatus *)status{
    if (type == YJYStatusToolBarButtonTypeRetweet) {
        YJYCommentViewController *comment = [[YJYCommentViewController alloc]init];
        comment.status = status;
        YJYNavigationController *nav = [[YJYNavigationController alloc]initWithRootViewController:comment];
        [self presentViewController:nav animated:YES completion:nil];
    }else if (type == YJYStatusToolBarButtonTypeComment){
        YJYCommentViewController *comment = [[YJYCommentViewController alloc]init];
        comment.status = status;
        YJYNavigationController *nav = [[YJYNavigationController alloc]initWithRootViewController:comment];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        YJYCommentViewController *comment = [[YJYCommentViewController alloc]init];
        comment.status = status;
        YJYNavigationController *nav = [[YJYNavigationController alloc]initWithRootViewController:comment];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

@end
