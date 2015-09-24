//
//  HHEmotionListView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/13.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionListView.h"
#import "HHEmotionPageView.h"

@interface HHEmotionListView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HHEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = HHColor(239, 239, 239);
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
//        scrollView.backgroundColor = [UIColor redColor];
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
        self.pageControl = pageControl;
        [self addSubview:pageControl];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.x = 0;
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    NSInteger count = self.scrollView.subviews.count;
    for (NSInteger i=0; i<count; i++)
    {
        HHEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.y = 0;
        pageView.width = self.scrollView.width;
        pageView.x = i * pageView.width;
        pageView.height = self.scrollView.height;
    }
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

- (void)setEmotionData:(NSArray *)emotionData
{
    _emotionData = emotionData;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger pageNum = [HHEmotionPageView pageNum];
    NSInteger count = (emotionData.count + pageNum - 1) / pageNum;
    self.pageControl.numberOfPages = count;
    
    for (NSInteger i=0; i<count; i++)
    {
        HHEmotionPageView *pageView = [[HHEmotionPageView alloc] init];
        
        NSRange range;
        range.location = i * pageNum;
        if (emotionData.count - range.location >= pageNum)
        {
            range.length = pageNum;
        }
        else
        {
            range.length = emotionData.count - range.location;
        }
        pageView.emotions = [emotionData subarrayWithRange:range];
        
        [self.scrollView addSubview:pageView];
    }
    
    [self setNeedsLayout];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (NSInteger)(pageNo + 0.5);
}

@end
