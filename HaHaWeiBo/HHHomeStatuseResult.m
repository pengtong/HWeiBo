//
//  HHHomeStatuseResult.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/14.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHHomeStatuseResult.h"
#import "MJExtension.h"
#import "HHStatus.h"

@implementation HHHomeStatuseResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses": [HHStatus class]};
}

@end
