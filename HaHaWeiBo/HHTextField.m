//
//  HHTextField.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/21.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHTextField.h"
#import "UIImage+HHImage.h"

@implementation HHTextField

+ (instancetype) searchBar
{
    return [[self alloc] init];
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSeachBar];
    }
    
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupSeachBar];
    }
    
    return self;
}


- (void) setupSeachBar
{
    self.background = [UIImage imageWithName:@"searchbar_textfield_background"];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
    iconView.contentMode = UIViewContentModeCenter;
    self.leftView = iconView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.font = [UIFont systemFontOfSize:13];
    self.clearButtonMode = UITextFieldViewModeAlways;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attr];
    self.returnKeyType = UIReturnKeySearch;
    self.enablesReturnKeyAutomatically = YES;
}

- (void)layoutSubviews
{
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
    [super layoutSubviews];
}

@end
