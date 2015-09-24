//
//  HHComposePhotoListView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/8.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHComposePhotoListView.h"
#import "QLAssetManager.h"
#import "QLAssetsModel.h"

#define ComposePhotoListViewMagir   10

@implementation HHComposePhotoListView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        for (int index=0; index<HHStatusPhotoCounts; index++)
        {
            UIImageView *photoView = [[UIImageView alloc] init];
            photoView.tag = index;
            photoView.userInteractionEnabled = YES;
            UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDownPhotoView:)];
            photoView.contentMode = UIViewContentModeScaleAspectFill;
            photoView.clipsToBounds = YES;
            [photoView addGestureRecognizer:touch];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)touchDownPhotoView:(UIGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(composePhotoListView:clickPhotosIndex:)])
    {
        [self.delegate composePhotoListView:self clickPhotosIndex:recognizer.view.tag];
    }
}

- (void)setPhotos:(NSMutableArray *)photos
{
    _photos = photos;
    
    for (int i = 0; i<self.subviews.count; i++)
    {
        UIImageView *photoView = self.subviews[i];
        
        if (i<photos.count)
        {
            photoView.hidden = NO;
            QLAssetsModel *asset = photos[i];
            photoView.image = asset.thumbnail;
            
            NSUInteger maxCol = photos.count > 2 ? 3 : photos.count;
            int col = i % maxCol;
            int row = i / maxCol;
            
            CGFloat phoneMagir = (self.width - (3 * HHStatusPhotoListWH + ComposePhotoListViewMagir)) / 3;
            
            CGFloat photoX = phoneMagir + col * (HHStatusPhotoListWH + ComposePhotoListViewMagir);
            CGFloat photoY = row * (HHStatusPhotoListWH + ComposePhotoListViewMagir);
            photoView.frame = CGRectMake(photoX, photoY, HHStatusPhotoListWH, HHStatusPhotoListWH);
            
        }
        else
        {
            photoView.hidden = YES;
        }
    }
}

@end
