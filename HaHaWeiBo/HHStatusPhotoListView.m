//
//  HHStatusPhotoListView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/7/2.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHStatusPhotoListView.h"
#import "HHStatusPhotoView.h"
#import "HZPhotoBrowser.h"
#import "HHPhoto.h"

@interface HHStatusPhotoListView () <HZPhotoBrowserDelegate>


@end

@implementation HHStatusPhotoListView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        for (int index=0; index<HHStatusPhotoCounts; index++)
        {
            HHStatusPhotoView *photoView = [[HHStatusPhotoView alloc] init];
            photoView.tag = index;
            UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDownPhotoView:)];
            [photoView addGestureRecognizer:touch];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)touchDownPhotoView:(UIGestureRecognizer *)recognizer
{
    HHLog(@"%ld", (long)recognizer.view.tag);
    
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = self;
    browserVc.imageCount = self.photos.count;
    browserVc.currentImageIndex = (int)recognizer.view.tag;
    browserVc.delegate = self;
    [browserVc show];
}


- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int i = 0; i<self.subviews.count; i++)
    {
        HHStatusPhotoView *photoView = self.subviews[i];
        
        if (i<photos.count)
        {
            photoView.hidden = NO;
            photoView.photo = photos[i];
            
            int maxCol = photos.count == 4 ? 2: 3;
            int col = i % maxCol;
            int row = i / maxCol;
            
            CGFloat photoX = col * (HHStatusPhotoListWH + HHStatusPhotoListMagir);
            CGFloat photoY = row * (HHStatusPhotoListWH + HHStatusPhotoListMagir);
            photoView.frame = CGRectMake(photoX, photoY, HHStatusPhotoListWH, HHStatusPhotoListWH);
            
//            if (photos.count == 1) {
//                photoView.contentMode = UIViewContentModeScaleAspectFit;
//                photoView.clipsToBounds = NO;
//            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
//            }
        }
        else
        {
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)sizeWithCounts:(int)counts
{
    int maxCol = counts == 4 ? 2: 3;
    
    int col = counts >= maxCol ? maxCol : counts;
    int photoW = col * HHStatusPhotoListWH + (col - 1) * HHStatusPhotoListMagir;
    
    int row = (counts + maxCol - 1) / maxCol;
    int photoH = row * HHStatusPhotoListWH + (row - 1) * HHStatusPhotoListMagir;
    
    return CGSizeMake(photoW, photoH);
}

#pragma mark - HZPhotoBrowserDelegate

- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    HHStatusPhotoView *photoView = self.subviews[index];
    
    return photoView.image;
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    HHPhoto *photo = self.photos[index];
    NSString *urlStr = [photo.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}
@end
