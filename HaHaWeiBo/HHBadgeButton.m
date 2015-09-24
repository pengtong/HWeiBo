//
//  HHBadgeButton.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/18.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHBadgeButton.h"
#import "UIImage+HHImage.h"
#import "NString+Extend.h"

@implementation HHBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setBackgroundImage:[UIImage imageWithName:@"main_badge"] forState:UIControlStateNormal];
    }
    
    return self;
}


- (void)setBadgeValue:(NSString *)badgeValue
{
    if ([badgeValue intValue] >= 100)
    {
        badgeValue = @"new";
    }
    
    _badgeValue = [badgeValue copy];
    
    if (badgeValue && ([badgeValue intValue] != 0))
    {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        CGRect frame = self.frame;
        CGFloat buttonW = self.currentBackgroundImage.size.width;
        CGFloat buttonH = self.currentBackgroundImage.size.height;
        
        if (badgeValue.length > 1)
        {
            CGSize buttonSize = [badgeValue sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, buttonH)];
            buttonW = buttonSize.width + 8;
        }
        frame.size.width = buttonW;
        frame.size.height = buttonH;
        self.frame = frame;
    }
    else
    {
        self.hidden = YES;
    }
}
@end
