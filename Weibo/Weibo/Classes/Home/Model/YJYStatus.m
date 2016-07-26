//
//  YJYStatus.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYStatus.h"

#import "YJYPhoto.h"
#import "YJYUser.h"
#import "NSDate+MJ.h"


@implementation YJYStatus

+(NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls":[YJYPhoto class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

-(void)setRetweeted_status:(YJYStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    _retweetedName = [NSString stringWithFormat:@"@%@", retweeted_status.user.name];
}

-(void)setSource:(NSString *)source{
    /*
     *<a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>
     *
     */
    
    if (source.length) {
        NSRange range = [source rangeOfString:@">"];
        source = [source substringFromIndex:range.location + range.length];
        range = [source rangeOfString:@"<"];
        source = [source substringToIndex:range.location];
//        NSLog(@"%@", source);
        source = [NSString stringWithFormat:@"来自%@", source];

    }else{
        source = @"来自微博";
    }
        _source = source;
}

-(NSString *)created_at{
    
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EE MM d HH:mm:ss Z yyyy";
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    
    NSDate *createDate = [fmt dateFromString:_created_at];
//    NSDate *now = [NSDate date];
//    
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
//    NSDateComponents *cmp = [calender components:unit fromDate:createDate toDate:now options:0];
    
    
    if ([self isThisYear:createDate]) {
            NSDateComponents *cmp = [createDate deltaWithNow];
        if ([createDate isToday]) {
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", cmp.hour];
            }else if(cmp.minute >=1){
                return [NSString stringWithFormat:@"%ld分钟前", cmp.minute];
            }else{
                return @"刚刚";
            }
            
            
        }else if([self isYestoday:createDate]){
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
        
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    
    }
    
    
    return _created_at;
}

-(BOOL)isThisYear:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateCmps = [calender components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowCmps = [calender components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

-(BOOL)isYestoday:(NSDate *)date{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:now];
    
    date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmp = [calender components:unit fromDate:date toDate:now options:0];
    
    return cmp.year == 0 && cmp.month == 0 && cmp.day == 1;
    
    
}

-(BOOL)isToday:(NSDate *)date{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}


@end
