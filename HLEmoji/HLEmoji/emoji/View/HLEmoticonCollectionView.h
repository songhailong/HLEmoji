//
//  HLEmoticonCollectionView.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/9/13.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExpressionCell;
@protocol HLEmoticonCollectionViewDelegate<UICollectionViewDelegate>
-(void)emoticonScrollViewDidTapCell:(ExpressionCell*)cell;
@end
@interface HLEmoticonCollectionView : UICollectionView

@end
