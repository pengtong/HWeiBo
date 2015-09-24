//
//  NString+Extend.m
//  QQChat
//
//  Created by Pengtong on 14-12-29.
//  Copyright (c) 2014年 Pengtong. All rights reserved.
//

#import "NString+Extend.h"

@implementation NSString (Extend)


- (CGSize) sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attr = @{NSFontAttributeName : font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
