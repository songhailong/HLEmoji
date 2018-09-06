//
//  AddViewHandleCell.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/30.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "AddViewHandleCell.h"

@implementation AddViewHandleCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        CGFloat H=self.frame.size.height;
        CGFloat W=self.frame.size.width;
        _imageBn=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, W, W)];
        _textLable=[[UILabel  alloc ] initWithFrame:CGRectMake(0, W, W, H-W)];
        [self.contentView  addSubview:_imageBn];
        [self.contentView addSubview:_textLable];
        _imageBn.backgroundColor=[UIColor clearColor];
        _textLable.backgroundColor=[UIColor clearColor];
        _textLable.textAlignment=NSTextAlignmentCenter;
        _textLable.font=[UIFont systemFontOfSize:17];
        _textLable.textColor=[UIColor grayColor];
    }
    return self;
}
@end
