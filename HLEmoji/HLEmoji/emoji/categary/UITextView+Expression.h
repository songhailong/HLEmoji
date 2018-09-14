//
//  UITextView+Expression.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/9/14.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Emoticon;
@interface UITextView (Expression)
-(void)insertWithEmoticon:(Emoticon *)emotion;
-(NSString *)emoticonAttributedText;
@end
