//
//  ExpressionInputView.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RATIO_WIDHT320 [UIScreen mainScreen].bounds.size.width/320.0
@class Emoticon;
@protocol ExpressionViewDelegate <NSObject>

/**
 用哪个表情
 */
@optional
-(void)selectWithExpression:(Emoticon *)emoticon;

/**
 发送按钮调用
 */
@optional
-(void)sendExpressionAction;
@optional
-(void)removeExpressionWithEmoticon:(Emoticon *)emoticon;
@end;
@interface ExpressionInputView : UIView
@property(nonatomic,weak)id<ExpressionViewDelegate>delegate;
@end
