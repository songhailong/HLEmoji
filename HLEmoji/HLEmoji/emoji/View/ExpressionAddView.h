//
//  ExpressionAddView.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,handleKeyType) {
    handleKeyTypePhoto,
    handleKeyTypeCamera,
    handleKeyTypeIphne,
    handleKeyTypAderess,
    handleKeyTypeFile,
};
typedef void(^handleComple)(handleKeyType type);
@interface ExpressionAddView : UIView
//消息回调
@property(nonatomic,copy)handleComple handleBlock;
-(void)handledidSelectAction:(handleComple)handleBlock;
@end
