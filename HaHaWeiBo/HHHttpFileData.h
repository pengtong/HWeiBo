//
//  HHHttpFileDate.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/12.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHHttpFileData : NSObject

@property (nonatomic, strong) NSData *data;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, copy) NSString *mimeType;

@end
