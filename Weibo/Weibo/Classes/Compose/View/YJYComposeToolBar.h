//
//  YJYComposeToolBar.h
//  Weibo
//
//  Created by yaojinye on 16/7/10.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJYComposeToolBar;
@protocol YJYComposeToolDelegate <NSObject>


-(void)composeToolBar:(YJYComposeToolBar *)toolBar btnClickedIndex:(NSInteger)index;

@end

@interface YJYComposeToolBar : UIView

@property (nonatomic, weak)id<YJYComposeToolDelegate>delegate;

@end
