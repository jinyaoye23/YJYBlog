//
//  YJYCommentViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/21.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYCommentViewController.h"
#import "YJYCommentView.h"
#import "YJYComposeToolBar.h"
#import "YJYComposeTool.h"
#import "YJYStatus.h"
#import "MBProgressHUD+MJ.h"

@interface YJYCommentViewController ()<YJYComposeToolDelegate,UITextViewDelegate>

@property (nonatomic, retain)YJYCommentView *commentView;
@property (nonatomic, weak)YJYComposeToolBar *toolBar;
@property (nonatomic, retain)UIBarButtonItem *composeBtn;


@end

@implementation YJYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationController];
    [self setupComposeView];
    [self setupToolBar];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_commentView becomeFirstResponder];
    
}

-(void)setupNavigationController{
    self.title = @"转发";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    UIBarButtonItem *rightItem= [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    _composeBtn = rightItem;
    _composeBtn.enabled = NO;
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)setupComposeView{
    YJYCommentView *commentView = [[YJYCommentView alloc]initWithFrame:self.view.bounds];
    
    commentView.placeholder = @"说些什么...";
    commentView.font = [UIFont systemFontOfSize:15];
    
    _commentView = commentView;
    [self.view addSubview:commentView];
    
    _commentView.delegate = self;
    _commentView.alwaysBounceVertical = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
}

-(void)textChange{
    if (_commentView.text.length) {
        _commentView.hidePlaceholder = YES;
        _composeBtn.enabled = YES;
    }else{
        _commentView.hidePlaceholder = NO;
        _composeBtn.enabled = NO;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(void)composeToolBar:(YJYComposeToolBar *)toolBar btnClickedIndex:(YJYComposeToolBarButtonType)btnType{

}
-(void)setupToolBar{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    YJYComposeToolBar *toolBar = [[YJYComposeToolBar alloc]initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
}

-(void)compose{
    
    [YJYComposeTool commentWithID:self.status.ID commentText:_commentView.text success:^{
        [MBProgressHUD showSuccess:@"Comment Success!"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"Comment Failure!"];
        NSLog(@"%@", error);
        
    }];
    
    
}


@end