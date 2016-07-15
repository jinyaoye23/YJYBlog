//
//  YJYPopView.h
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJYPopView;
@protocol  YJYPopViewDelegate<NSObject>

-(void)popViewDidDismiss:(YJYPopView *)popView;

@end

@interface YJYPopView : UIView

@property (nonatomic, weak)UIView *contentView;
@property (nonatomic, weak)id<YJYPopViewDelegate>delegate;

+(instancetype)createPopView;

- (void)showInRect:(CGRect)rect;

@end
