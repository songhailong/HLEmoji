//
//  ExpressionInputView.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ExpressionViewDelegate <NSObject>

/**
 用哪个表情
 */
-(void)selectWithExpression:(NSString *)expression;

/**
 发送按钮调用
 */
-(void)sendExpressionAction;
@end;
@interface ExpressionInputView : UIView
@property(nonatomic,weak)id<ExpressionViewDelegate>delegate;
@end
