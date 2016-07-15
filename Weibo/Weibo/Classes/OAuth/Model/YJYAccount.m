//
//  YJYAccount.m
//  Weibo
//
//  Created by yaojinye on 16/7/5.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYAccount.h"

#define YJYAccountTokenKey @"token"
#define YJYUidKey @"uid"
#define YJYExpires_inKey @"expires"
#define YJYExpires_dateKey @"date"
#define YJYNameKey @"name"

#import "MJExtension.h"

@implementation YJYAccount
//底层遍历当前类的所有属性， 一个一个的归档和解档
//MJCodingImplementation

+(instancetype)accountWithDict:(NSDictionary *)dic{
    YJYAccount *account = [[self alloc]init];
    [account setValuesForKeysWithDictionary:dic];
    return account;
}

-(void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_access_token forKey:YJYAccountTokenKey];
    [aCoder encodeObject:_expires_in forKey:YJYExpires_inKey];
    [aCoder encodeObject:_uid forKey:YJYUidKey];
    [aCoder encodeObject:_expires_date forKey:YJYExpires_dateKey];
    [aCoder encodeObject:_name forKey:YJYNameKey];

}
//归档时候调用：告诉系统哪个属性需要归档，如何归档

//解档时候调用：告诉系统哪个属性需要解档，如何解档
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _access_token  = [aDecoder decodeObjectForKey:YJYAccountTokenKey];
        _expires_in = [aDecoder decodeObjectForKey:YJYExpires_inKey];
        _uid = [aDecoder decodeObjectForKey:YJYUidKey];
        _expires_date = [aDecoder decodeObjectForKey:YJYExpires_dateKey];
        _name = [aDecoder decodeObjectForKey:YJYNameKey];
    }
    return self;
}

@end
