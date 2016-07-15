//
//  YJYStatusDataTool.m
//  Weibo
//
//  Created by yaojinye on 16/7/11.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYStatusDataTool.h"
#import "FMDatabase.h"
#import "YJYStatusParam.h"
#import "YJYStatus.h"

static FMDatabase *_db;
@implementation YJYStatusDataTool

+(void)initialize{
   
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"];
}

+(NSArray *)statusesWithParams:(NSDictionary *)param{


    NSString *sql = nil;
    if (param[@"since_id"]) {
        
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", param[@"since_id"]];
    }else if (param[@"max_id"]){
        
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;", param[@"max_id"]];
    }else{
        
        sql = @"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20;";
    }
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
       NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    
    return statuses;
}

+(NSArray *)statusesWithStatuses:(YJYStatusParam *)statusParam{
    NSString *sql = nil;
    if (statusParam.since_id) {
        
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", statusParam.since_id];
    }else if (statusParam.max_id){
        
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;", statusParam.max_id];
    }else{
        
        sql = @"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20;";
    }
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *temp = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        NSLog(@"%@", status);
        
        [temp addObject:status];
        
    }
    NSMutableArray *statuses = [YJYStatus mj_objectArrayWithKeyValuesArray:temp];
    
    return statuses;
}

+(void)saveStatuses:(NSArray *)statuses{
    NSArray *arr = [YJYStatus mj_keyValuesArrayWithObjectArray:statuses];
    for (NSDictionary *status in arr) {
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status, idstr) VALUES (%@, %@);", statusData, status[@"idstr"]];
        NSLog(@"Save Success");
    }
}


@end
