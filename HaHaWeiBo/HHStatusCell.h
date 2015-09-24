//
//  HHSatatusCell.h
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/28.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHStatusFrame;

@interface HHStatusCell : UITableViewCell

@property (nonatomic, strong) HHStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
