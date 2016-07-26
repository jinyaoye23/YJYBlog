//
//  YJYBaseVC.m
//  Weibo
//
//  Created by yaojinye on 16/7/21.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYBaseVC.h"
#import "YJYComposeToolBar.h"

@interface YJYBaseVC ()

@property (nonatomic, strong)UIBarButtonItem *composeBtn;
@property (nonatomic, weak)YJYComposeToolBar *toolBar;

@end

@implementation YJYBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationbar];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)keyboardFrameChange:(NSNotification *)note{
    
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.height) {
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformIdentity;
        }];
    }else{
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}


-(void)setupNavigationbar{
    
    self.title = @"发微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)compose{

}

@end
