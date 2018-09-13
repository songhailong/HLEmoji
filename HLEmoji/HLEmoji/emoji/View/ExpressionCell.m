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
       // NSLog(@"cell创建");
        self.backgroundColor=[UIColor greenColor];
        _ivImg = [[UIButton alloc]init];
        _ivImg.frame=CGRectMake(10, 10, 32, 32);
        _ivImg.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _ivImg.userInteractionEnabled=NO;
        _ivImg.backgroundColor=[UIColor redColor];
        _ivImg.contentMode=UIViewContentModeScaleAspectFit;
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
     [_ivImg  setImage:nil forState:UIControlStateNormal];
     [_ivImg setTitle:nil forState:UIControlStateNormal];;
    if (_emoticon.isRemove) {
        //_ivImg.image=[UIImage imageNamed:@"compose_emotion_delete"];
        [_ivImg setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    }else if (_emoticon){
        
        
        
        
        if (_emoticon.type==EmoticonTypeImage) {
            if (_emoticon.imagePath!=nil) {
                [_ivImg setImage:[UIImage imageWithContentsOfFile:_emoticon.imagePath] forState:UIControlStateNormal];
            }else{
                [_ivImg  setImage:nil forState:UIControlStateNormal];
            }
        }else if (_emoticon.type==EmoticonTypeEmoji){
            if (_emoticon.emotionStr) {
               [_ivImg  setImage:nil forState:UIControlStateNormal];
                [_ivImg setTitle:_emoticon.emotionStr forState:UIControlStateNormal];
            }else
            {
                [_ivImg setTitle:nil forState:UIControlStateNormal];
            }
        }else if (_emoticon.type==EmoticonTypeRemove){
             {
                
            }
        }
    }
}
- (void)loadData:(NSString*)imageName{
    //self.ivImg.image=[UIImage imageNamed:imageName];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //self.ivImg.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //self.ivImg.center=self.center;
    
}
@end
