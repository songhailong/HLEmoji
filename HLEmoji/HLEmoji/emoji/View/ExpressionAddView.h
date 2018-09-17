//
//  ExpressionAddView.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpreessionHeader.h"
typedef void(^handleComple)(handleKeyType type);
@interface ExpressionAddView : UIView
@property(nonatomic,assign)handleKeyType keyType;
//消息回调
@property(nonatomic,copy)handleComple handleBlock;
-(void)handledidSelectAction:(handleComple)handleBlock;
@end
