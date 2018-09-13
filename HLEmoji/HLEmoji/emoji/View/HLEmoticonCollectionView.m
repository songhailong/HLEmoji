//
//  HLEmoticonCollectionView.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/9/13.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "HLEmoticonCollectionView.h"
#import "ExpressionCell.h"
@implementation HLEmoticonCollectionView{
    NSTimeInterval *_touchBeganTime;
    BOOL _touchMoved;
    UIImageView *_magnifier;
    UIImageView *_magnifierContent;
    __weak ExpressionCell *_currentMagnifierCell;
    NSTimer *_backspaceTimer;
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    return self;
}
@end
