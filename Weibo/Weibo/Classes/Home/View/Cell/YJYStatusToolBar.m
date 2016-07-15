
//
//  YJYStatusToolBar.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYStatusToolBar.h"
#import "YJYStatus.h"

@interface YJYStatusToolBar ()

@property (nonatomic, strong)NSMutableArray *btns;
@property (nonatomic, strong)NSMutableArray *dividesV;

@property (nonatomic, weak)UIButton *retweet;
@property (nonatomic, weak)UIButton *comment;
@property (nonatomic, weak)UIButton *unlink;


@end

@implementation YJYStatusToolBar

-(NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

-(NSMutableArray *)dividesV{
    if (!_dividesV) {
        _dividesV = [NSMutableArray array];
    }
    return _dividesV;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        [self setupAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage strechableImage:@"timeline_card_bottom_background"];
        
        
    }
    return self;
}

-(void)setupAllChildView{
    UIButton *retweet = [self setupOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_retweet"] title:@"转发"];
    _retweet = retweet;
    
    UIButton *comment = [self setupOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_comment"] title:@"评论"];
    _comment = comment;
    
    UIButton *unlink = [self setupOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_unlike"] title:@"赞"];
    _unlink = unlink;
    
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.dividesV addObject:divideV];
    }
    
}

-(UIButton *)setupOneButtonWithImage:(UIImage *)image title:(NSString *)title{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:button];
    [self.btns addObject:button];
//    WBLog(@"add btn");
    
    return button;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.btns.count;
    CGFloat w = YJYScreenWidth / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];
        x = w * i;
        btn.frame = CGRectMake(x, y, w, h);
    }
    int i = 1;
    for (UIImageView *divide in self.dividesV) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
}

-(void)setStatus:(YJYStatus *)status{
    _status = status;
    
    [self setBtn:_retweet title:status.reposts_count];
    
    [self setBtn:_comment title:status.comments_count];
    
    [self setBtn:_unlink title:status.attitudes_count];
    
    

}

-(void)setBtn:(UIButton *)btn title:(int)count{
    
    NSString *title = nil;
    if (count) {
        
        if (count >= 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW", floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{
            
            title = [NSString stringWithFormat:@"%i", count];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    }

}


@end
