//
//  YJYTabBar.m
//  Weibo
//
//  Created by yaojinye on 16/7/4.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYTabBar.h"
#import "YJYTabBarButton.h"

@interface YJYTabBar ()

@property (nonatomic, weak)UIButton *plusButton;
@property (nonatomic, copy)NSMutableArray *tarBarButtons;

@end

@implementation YJYTabBar

-(NSMutableArray *)tarBarButtons{
    if (!_tarBarButtons) {
        _tarBarButtons = [NSMutableArray array];
    }
    return _tarBarButtons;
}


-(UIButton *)plusButton{
    if (!_plusButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(plusClicked) forControlEvents:UIControlEventTouchUpInside];
        _plusButton = btn;
        
        [btn sizeToFit];
        [self addSubview:_plusButton];
        
    }
    return _plusButton;
}


//-(void)addTarBarButtonWithItem:(UITabBarItem *)item{
//    YJYTabBarButton *button = [YJYTabBarButton buttonWithType:UIButtonTypeCustom];
//    button.item = item;
//    button.tag = self.tarBarButtons.count;
//    if (button.tag == 0) {
//        button.selected = YES;
//    }
//    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:button];
//    [self.tarBarButtons addObject:button];
//    
//    
//}

-(void)btnClicked:(UIButton *)btn{

}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / 5;
    CGFloat btnH = h;
    
    int i = 0;
    for (UIView *tarBarButton in self.subviews) {
        if ([tarBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i = 3;
            }
            btnX = i * btnW;
            
            tarBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
    self.plusButton.size = [self.plusButton backgroundImageForState:UIControlStateNormal].size;
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
}


-(void)plusClicked{
    
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
    
}

@end
