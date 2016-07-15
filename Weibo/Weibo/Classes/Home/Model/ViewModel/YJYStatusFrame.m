//
//  YJYStatusFrame.m
//  Weibo
//
//  Created by yaojinye on 16/7/6.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYStatusFrame.h"
#import "YJYStatus.h"
#import "YJYUser.h"
#import "MJExtension.h"

#define YJYStatusCellMargin 10


@implementation YJYStatusFrame

-(void)setStatus:(YJYStatus *)status{
    _status = status;
    
    [self setupOriginViewFrame];
    
    CGFloat toolBarY =CGRectGetMaxY(_originViewFrame);
    if (_status.retweeted_status) {
        
        [self setupRetweetViewFrame];
        toolBarY =CGRectGetMaxY(_retweetViewFrame);
    }
    CGFloat toolBarX = 0;
    CGFloat toolBarW = YJYScreenWidth;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}


-(void)setupOriginViewFrame{
    
    //IconIV
    CGFloat imageX = YJYStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //Name
    CGFloat nameX = CGRectGetMaxX(_originIconFrame) + YJYStatusCellMargin;
    CGFloat nameY = YJYStatusCellMargin;
    CGSize nameSize = [_status.user.name sizeWithFont:YJYNameFont];
    _originNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    //Vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originNameFrame) + YJYStatusCellMargin;
        CGFloat vipY = imageY;
        CGFloat vipWH = 14;
        _originViptFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    //Time
    CGFloat timeX = CGRectGetMaxX(_originIconFrame) + YJYStatusCellMargin;
    CGFloat timeY = CGRectGetMaxY(_originNameFrame) + YJYStatusCellMargin * 0.5;
    CGSize timeSize = [_status.user.name sizeWithFont:YJYTimeFont];
    _originTimeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    //Source
    CGFloat sourceX = CGRectGetMaxX(_originTimeFrame) + YJYStatusCellMargin;
    CGFloat sourceY = CGRectGetMaxY(_originNameFrame) + YJYStatusCellMargin * 0.5;
    CGSize sourceSize = [_status.source sizeWithFont:YJYSourceFont];
    _originSourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    //Text
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originIconFrame) + YJYStatusCellMargin;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2 * YJYStatusCellMargin;
    CGSize textSize = [_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YJYTextFont} context:nil].size;
    _originTextFrame = (CGRect){{textX, textY}, textSize};
    CGFloat originH = CGRectGetMaxY(_originTextFrame) + YJYStatusCellMargin;
    
    //Photos
    if (_status.pic_urls.count) {
        
        CGFloat photosX = YJYStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originTextFrame) + YJYStatusCellMargin;
        CGSize photosSize = [self photoeSizeWithCount:_status.pic_urls.count];
        _originPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        originH = CGRectGetMaxY(_originPhotosFrame) + YJYStatusCellMargin;
    
    }

    //OriginView
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = YJYScreenWidth;
    _originViewFrame = CGRectMake(originX, originY, originW, originH);

}
-(CGSize)photoeSizeWithCount:(int)count{
    
    //获取总列数
    int cols = count == 4? 2 : 3;
    //获取总行数 ＝ （总个数 － 1）／ 总列数 ＋ 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * YJYStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * YJYStatusCellMargin;
    
    return CGSizeMake(w, h);
}

-(void)setupRetweetViewFrame{

    //Name
    CGFloat nameX = YJYStatusCellMargin;
    CGFloat nameY = YJYStatusCellMargin;
    CGFloat nameW = YJYScreenWidth;
    CGSize nameSize = [_status.retweetedName sizeWithFont:YJYNameFont];
    _retweetNameFrame = (CGRect){{nameX, nameY}, nameSize};

    //Text
    CGFloat textX = YJYStatusCellMargin;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + YJYStatusCellMargin;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2 * YJYStatusCellMargin;
    CGSize textSize = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YJYTextFont} context:nil].size;
    _retweetextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetextFrame) + YJYStatusCellMargin * 0.5;
    
    //Photos
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
       
        CGFloat photosX = YJYStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetextFrame) + YJYStatusCellMargin;
        CGSize photosSize = [self photoeSizeWithCount:count];
        _retweetPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + YJYStatusCellMargin;
    }
    
    //RetweetView
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originViewFrame);
    CGFloat retweetW = YJYScreenWidth;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}

@end
