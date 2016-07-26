//
//  YJYComposeToolBar.h
//  Weibo
//
//  Created by yaojinye on 16/7/10.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YJYComposeToolBarButtonTypePicture,
    YJYComposeToolBarButtonTypeTrend,
    YJYComposeToolBarButtonTypeMentionType,
    YJYComposeToolBarButtonTypeEmoticon
}YJYComposeToolBarButtonType;

@class YJYComposeToolBar;
@protocol YJYComposeToolDelegate <NSObject>


-(void)composeToolBar:(YJYComposeToolBar *)toolBar btnClickedIndex:(YJYComposeToolBarButtonType)btnType;

@end

@interface YJYComposeToolBar : UIView

@property (nonatomic, weak)id<YJYComposeToolDelegate>delegate;

@end
