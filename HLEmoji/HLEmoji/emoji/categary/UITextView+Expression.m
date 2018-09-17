//
//  UITextView+Expression.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/9/14.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "UITextView+Expression.h"
#import "Emoticon.h"
#import "EmotiocnTextAttachment.h"
@implementation UITextView (Expression)
-(void)insertWithEmoticon:(Emoticon *)emotion{
    if (emotion.emotionStr!=nil) {
        [self replaceRange:self.selectedTextRange withText:emotion.emotionStr];
    }else if (emotion.imagePath!=nil){
       // [self replaceRange:self.selectedTextRange withText:emotion.chs];
        /**显示表情*/
        //创建附件
        EmotiocnTextAttachment *attachment=[[EmotiocnTextAttachment alloc] init];
        attachment.image=[UIImage imageWithContentsOfFile:emotion.imagePath];
        attachment.cht=emotion.cht;
        attachment.bounds=CGRectMake(0, -4, 17,17);
        //根据附件创建属性字符串
        NSAttributedString *imagetext=[NSAttributedString attributedStringWithAttachment:attachment];
        //拿到当前所有内容  因为replaceRange:self.selectedTextRange withText: 只能替换字符串
        NSMutableAttributedString *strM=[[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        NSRange range=self.selectedRange;
        //插入表情到光标的所在位置
        [strM replaceCharactersInRange:self.selectedRange withAttributedString:imagetext];
        //属性字符串有自己默认的尺寸
        [strM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(range.location, 1)];
        
        //将替换后的字符串赋值
        self.attributedText=strM;
        //恢复光标位置  重新赋值后光标会放在
        
        self.selectedRange=NSMakeRange(range.location+1, 0);
    
        [self.delegate textViewDidChange:self];
        
    }
}

-(NSString *)emoticonAttributedText{
    NSMutableString *string=[[NSMutableString alloc] init];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull object, NSRange range, BOOL * _Nonnull stop) {
        //rang 就是纯字符串的范围
        //object 中间有图片表情 rang 传多次
        if(object[@"NSAttachment"]!=nil){
            //有  NSAttachment是图片
            EmotiocnTextAttachment *emo=[object objectForKey:@"NSAttachment"];
            [string stringByAppendingString:emo.cht];
        }else{
            [string stringByAppendingString:[self.text substringWithRange:range]];
        }
    }];
    return string;
}

@end
