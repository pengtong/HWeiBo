//
//  HHHomeStatuseTool.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHHomeStatusCacheTool.h"
#import "HHStatus.h"
#import "HHAccount.h"
#import "HHAccountTool.h"
#import "MJExtension.h"
#import "FMDB.h"

@interface HHHomeStatusCacheTool ()


@end

@implementation HHHomeStatusCacheTool

static FMDatabaseQueue *_queue;

+ (void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    _queue = [[FMDatabaseQueue alloc] initWithPath:path];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, status blob);"];
    }];
}

+ (void)addStatus:(HHStatus *)status
{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *access_token = [HHAccountTool account].access_token;
        NSString *idstr = status.idstr;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        
        [db executeUpdate:@"insert into t_status (access_token, idstr, status) values(?, ?, ?);", access_token, idstr, data];
    }];
}

+ (void)addStatuses:(NSArray *)statusArray
{
    for (HHStatus *status in statusArray)
    {
        [self addStatus:status];
    }
}

+ (NSArray *)statusWithParame:(HHHomeStatuseParame *)parame
{
    __block NSMutableArray *statusArray = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        statusArray = [NSMutableArray array];
        NSString *access_token = [HHAccountTool account].access_token;
        FMResultSet *rs = nil;
        
        if (parame.since_id)
        {
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?", access_token, parame.since_id, parame.count];
        }
        else if (parame.max_id)
        {
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?", access_token, parame.max_id, parame.count];
        }
        else
        {
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?", access_token, parame.count];
            HHLog(@"%@",parame.count);
        }
        
        while (rs.next)
        {
            NSData *data = [rs dataForColumn:@"status"];
            HHStatus *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:status];
        }
        
    }];
    
    return statusArray;
}

@end
