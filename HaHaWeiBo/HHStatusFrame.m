//
//  HHStatusFrame.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/28.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHStatusFrame.h"
#import "HHUser.h"
#import "HHStatus.h"
#import "HHStatusPhotoListView.h"


#define HHStatusCellIconWH          40
#define HHStatusCellVipW            14
#define HHStatusCellNameH           12
#define HHStatusCellTimeH           10
#define HHStatusCellToolH           30

@implementation HHStatusFrame


- (void)setStatus:(HHStatus *)status
{
    _status = status;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat topViewXY = 0;
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    
    //头像
    CGFloat iconViewX = HHStatusCellBorder;
    CGFloat iconViewY = HHStatusCellBorder;
    CGFloat iconViewWH = HHStatusCellIconWH;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    //名称
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + HHStatusCellBorder;
    CGFloat nameY = iconViewY;
    CGSize  NameMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize nameSize = [status.user.name sizeWithFont:HHStatusCellNameFont maxSize:NameMaxSize];
    _nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    //VIP图标
    if (status.user.isVip)
    {
        CGFloat vipX = CGRectGetMaxX(_nameLabelF) + HHStatusCellBorder;
        CGFloat vipY = nameY;
        CGFloat vipW = HHStatusCellVipW;
        CGFloat vipH = HHStatusCellVipW;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameLabelF) + HHStatusCellBorder;
    CGSize timeMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize timeSize = [status.created_at sizeWithFont:HHStatusCellTimeFont maxSize:timeMaxSize];
    _timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) + HHStatusCellBorder;
    CGFloat sourceY = timeY;
    CGSize sourceMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize sourcSize = [status.source sizeWithFont:HHStatusCellSourceFont maxSize:sourceMaxSize];
    _sourceLabelF = (CGRect){{sourceX, sourceY}, sourcSize};
    //正文
    CGFloat contentX = iconViewX;
    CGFloat contentY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + HHStatusCellBorder;
    CGSize contentMaxSize = CGSizeMake(cellW - 2 * HHStatusCellBorder, MAXFLOAT);
//    CGSize contentSize = [status.text sizeWithFont:HHStatusCellContentFont maxSize:contentMaxSize];
    CGSize contentSize = [status.attrString boundingRectWithSize:contentMaxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    //配图
    if (status.pic_urls.count)
    {
        CGSize photoWH = [HHStatusPhotoListView sizeWithCounts:(int)status.pic_urls.count];
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(_contentLabelF) + HHStatusCellBorder;
        _photoViewF = (CGRect){{photoX, photoY}, photoWH};
    }
    //被转发微博
    if (status.retweeted_status)
    {
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + HHStatusCellBorder;
        CGFloat retweetViewW = cellW;
        CGFloat retweetViewH = 0;
        //被转微博的名称
        CGFloat retweetNameXY = HHStatusCellBorder;
        CGSize  retweetNameMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
        NSString *retweetName = [NSString stringWithFormat:@"@%@:", status.retweeted_status.user.name];
        CGSize  retweetnameSize = [retweetName sizeWithFont:HHStatusCellRetweetNameFont maxSize:retweetNameMaxSize];
        _retweetNameLabelF = (CGRect){{retweetNameXY, retweetNameXY}, retweetnameSize};
        //被转发微博的正文
        CGFloat retweetContentX = retweetNameXY;
        CGFloat retweetContentY = CGRectGetMaxY(_retweetNameLabelF) + HHStatusCellBorder;
        CGSize  retweetContentMaxSize = CGSizeMake(cellW - 2 * HHStatusCellBorder, MAXFLOAT);
//        CGSize  retweetContentSize = [status.retweeted_status.text sizeWithFont:HHStatusCellRetweetContentFont maxSize:retweetContentMaxSize];
        CGSize  retweetContentSize = [status.retweeted_status.attrString boundingRectWithSize:retweetContentMaxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        //被转发微博的配图
        if (status.retweeted_status.pic_urls.count)
        {
            CGSize retweetPhotoWH = [HHStatusPhotoListView sizeWithCounts:(int)status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(_retweetContentLabelF) + HHStatusCellBorder;
            _retweetPhotoViewF = (CGRect){{retweetPhotoX, retweetPhotoY}, retweetPhotoWH};
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        }
        else
        {
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += HHStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        topViewH = CGRectGetMaxY(_retweetViewF);
    }
    else
    {
        if (status.pic_urls.count)
        {
            topViewH = CGRectGetMaxY(_photoViewF) + HHStatusCellBorder * 0.5;
        }
        else
        {
            topViewH = CGRectGetMaxY(_contentLabelF) + HHStatusCellBorder * 0.5;
        }
    }
    //topView
    
    _topViewF = CGRectMake(topViewXY, topViewXY, topViewW, topViewH);
    //tool
    CGFloat toolBarX = topViewXY;
    CGFloat toolBarY = status.retweeted_status ? CGRectGetMaxY(_topViewF) - 1 : CGRectGetMaxY(_topViewF);
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = HHStatusCellToolH;
    _statusToolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    //cell Height
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + HHStatusCellBorder;;
}
@end
