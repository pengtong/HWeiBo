//
//  HHStatus.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/6/28.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHStatus.h"
#import "NSDate+HH.h"
#import "MJExtension.h"
#import "HHPhoto.h"
#import "HHTextPatter.h"
#import "RegexKitLite.h"
#import "HHEmotion.h"
#import "HHEmotionTool.h"
#import "HHSpecial.h"

@implementation HHStatus

MJCodingImplementation

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [HHPhoto class], @"spceials" : [HHSpecial class], @"retweetedSpceials" : [HHSpecial class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate = [fmt dateFromString:_created_at];
   
    if (!createDate)
    {
        return _created_at;
    }
    
    if ([createDate isToday])
    {
        if ([createDate deltaWithNow].hour >= 1)
        {
            return [NSString stringWithFormat:@"%ld小时前", (long)[createDate deltaWithNow].hour];
        }
        else if ([createDate deltaWithNow].minute >= 1)
        {
            return [NSString stringWithFormat:@"%ld分钟前", (long)[createDate deltaWithNow].minute];
        }
        else
        {
            return @"刚刚";
        }
    }
    else if ([createDate isYesterday])
    {
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    }
    else if ([createDate isThisYear])
    {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    else
    {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

- (void)setSource:(NSString *)source
{
    HHLog(@"%@", source);
    if(source)
    {
        NSRange rangeLoc = [source rangeOfString:@">"];
        NSRange rangeLength = [source rangeOfString:@"</"];
        
        if (rangeLoc.location != NSNotFound && rangeLength.location != NSNotFound)
        {
            NSUInteger loc = rangeLoc.location + 1;
            NSUInteger len = rangeLength.location - loc;
            source = [source substringWithRange:NSMakeRange(loc, len)];
            _source = [NSString stringWithFormat:@"来自 %@", source];
        }
        else
        {
            _source = source;
        }
    }
    else
    {
        _source = @"来自 新浪微博";
    }
    HHLog(@"%@", _source);
}

- (NSMutableAttributedString *)attrbutedWithText:(NSString *)text font:(UIFont *)font
{
    NSMutableAttributedString *attrbutedString = [[NSMutableAttributedString alloc] init];
    
    NSString *emotionPatter = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    NSString *atPatter = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    NSString *topicPatter = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    NSString *urlPatter = @"[a-zA-z]+://[^\\s]*";
    NSString *patter = [NSString stringWithFormat:@"%@|%@|%@", atPatter, topicPatter, urlPatter];
    NSString *separatePatter = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPatter,atPatter, topicPatter, urlPatter];
    
    NSMutableArray *parts = [NSMutableArray array];
    [_text enumerateStringsMatchedByRegex:patter usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop)
     {
         if ((*capturedRanges).length == 0) return;
         HHTextPatter *textPatter = [[HHTextPatter alloc] init];
         textPatter.special = YES;
         textPatter.text = *capturedStrings;
         textPatter.rang = *capturedRanges;
         [parts addObject:textPatter];
     }];
    
    [_text enumerateStringsMatchedByRegex:emotionPatter usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop)
     {
         if ((*capturedRanges).length == 0) return;
         HHTextPatter *textPatter = [[HHTextPatter alloc] init];
         textPatter.emotion = YES;
         textPatter.text = *capturedStrings;
         textPatter.rang = *capturedRanges;
         [parts addObject:textPatter];
     }];
    
    [_text enumerateStringsSeparatedByRegex:separatePatter usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        HHTextPatter *textPatter = [[HHTextPatter alloc] init];
        textPatter.text = *capturedStrings;
        textPatter.rang = *capturedRanges;
        [parts addObject:textPatter];
    }];
    
    [parts sortUsingComparator:^NSComparisonResult(HHTextPatter *obj1, HHTextPatter *obj2) {
        if (obj1.rang.location > obj2.rang.location)
        {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    
    NSMutableArray *specials = [NSMutableArray array];
    for (HHTextPatter *part in parts)
    {
        NSAttributedString *substr = nil;
        if (part.isSpecial)
        {
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName:[UIColor colorWithRed:67/255.0 green:107/255.0 blue:163/255.0 alpha:1]
                                                                                       
                                                                                       }];
            HHSpecial *special = [[HHSpecial alloc] init];
            special.text = part.text;
            special.rang = NSMakeRange(part.rang.location, part.rang.length);
            [specials addObject:special];
        }
        else if (part.isEmotion)
        {
            NSTextAttachment *atch = [[NSTextAttachment alloc] init];
            atch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
            HHEmotion *emotion = [HHEmotionTool emotionWithString:part.text];
            if (emotion)
            {
                atch.image = [UIImage imageWithName:emotion.png];
                substr = [NSAttributedString attributedStringWithAttachment:atch];
            }
            else
            {
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        }
        else
        {
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        
        [attrbutedString appendAttributedString:substr];
    }
    
    [attrbutedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrbutedString.length)];
    
    if (specials.count != 0)
    {
        if ([font isEqual:HHStatusCellContentFont])
        {
            self.spceials = specials;
        }
        else
        {
            self.retweetedSpceials = specials;
        }
    }

    return attrbutedString;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];

    self.attrString = [self attrbutedWithText:text font:HHStatusCellContentFont];
    self.retweetedAttrString = [self attrbutedWithText:text font:HHStatusCellRetweetContentFont];
}

@end
