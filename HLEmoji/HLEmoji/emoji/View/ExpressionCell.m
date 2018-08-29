//
//  ExpressionCell.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "ExpressionCell.h"
#import "UIImage+Category.h"
@implementation ExpressionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _ivImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_ivImg];
    }
    return self;
}
- (void)loadData:(NSString*)imageName{
    self.ivImg.image=[UIImage imageNamed:imageName];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.ivImg.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}
@end
