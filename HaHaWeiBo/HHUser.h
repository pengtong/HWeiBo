//
//  HHUser.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/26.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    HHUserVerifiedTypeNone = -1,
    HHUserVerifiedTypeAvatarVip = 0,
    HHUserVerifiedTypeEnterpriseVip = 1,
    HHUserVerifiedTypeEnterpriseZFVip = 2,
    HHUserVerifiedTypeMedioVip = 3,
    HHUserVerifiedTypeWebVip = 4,
    HHUserVerifiedTypeCampusVip = 5,
    HHUserVerifiedTypeAvatarGrassrootVip = 220
}HHUserVerifiedType;

@interface HHUser : NSObject

@property (nonatomic, copy) NSString *idstr;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *profile_image_url;

@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign) int mbtype;

@property (nonatomic, assign, getter=isVip)BOOL vip;

@property (nonatomic, assign) HHUserVerifiedType verified_type;

@end
