//
//  YJYStatusToolBar.h
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJYStatusToolBar;
@class YJYStatus;
typedef enum{
    YJYStatusToolBarButtonTypeRetweet,
    YJYStatusToolBarButtonTypeComment,
    YJYStatusToolBarButtonTypeAttribude
}YJYStatusToolBarButtonType;

@protocol  YJYStatusToolBarDelegate<NSObject>

-(void)statusToorBarButonClicked:(YJYStatusToolBarButtonType )type status:(YJYStatus *)status;

@end

@class YJYStatus;
@interface YJYStatusToolBar : UIImageView

@property (nonatomic, strong)YJYStatus *status;

@property (nonatomic, weak)id<YJYStatusToolBarDelegate>delegate;

@end
