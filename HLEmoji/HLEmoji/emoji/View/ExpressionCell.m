//
//  ExpressionCell.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "ExpressionCell.h"
#import "UIImage+Category.h"
#import "Emoticon.h"
@implementation ExpressionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _ivImg = [[UIImageView alloc]init];
        _ivImg.frame=CGRectMake(0, 0, 32, 32);
        _ivImg.center=self.center;
        
        [self.contentView addSubview:_ivImg];
    }
    return self;
}
-(void)setEmoticon:(Emoticon *)emoticon{
    _emoticon=emoticon;
    [self updataContent];
}
-(void)setIsDelete:(BOOL)isDelete{
    _isDelete=isDelete;
    [self updataContent];
}
-(void)updataContent{
    if (_isDelete) {
        _ivImg.image=[UIImage imageNamed:@"compose_emotion_delete"];
        
    }else if (_emoticon){
        if (_emoticon.type==EmoticonTypeImage) {
            if (_emoticon.imagePath!=nil) {
                _ivImg.image=[UIImage imageWithContentsOfFile:_emoticon.imagePath];
            }else{
                _ivImg.image=nil;
            }
        }else if (_emoticon.type==EmoticonTypeEmoji){
            if (_emoticon.emotionStr) {
                UIImage  *image=[UIImage imageWithEmoji:_emoticon.emotionStr size:_ivImg.frame.size.width];
                _ivImg.image=image;
            }else
            {
               _ivImg.image=nil;
            }
        }
    }
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
