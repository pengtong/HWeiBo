//
//  HHEmotionTextView.m
//  HaHaWeiBo
//
//  Created by Pengtong on 15/9/15.
//  Copyright (c) 2015年 Pengtong. All rights reserved.
//

#import "HHEmotionTextView.h"
#import "NSString+Emoji.h"
#import "UITextView+Extend.h"
#import "HHEmotion.h"
#import "HHEmotionTextAttachment.h"

@implementation HHEmotionTextView

- (void)insertEmotion:(HHEmotion *)emotion
{
    if (emotion.code)
    {
        [self insertText:[emotion.code emoji]];
    }
    else if (emotion.png)
    {
        HHEmotionTextAttachment *ach = [[HHEmotionTextAttachment alloc] init];
        ach.emotion = emotion;
        CGFloat achWH = self.font.lineHeight;
        ach.bounds = CGRectMake(0, -4, achWH, achWH);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:ach];
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
    
}

- (NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop)
    {
        HHEmotionTextAttachment *ach = attrs[@"NSAttachment"];
        if (ach)
        {
            [fullText appendString:ach.emotion.chs];
        }
        else
        {
            NSAttributedString *attrStr = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:attrStr.string];
        }
    }];
    HHLog(@"%@", fullText);
    return fullText;
}

@end
