//
//  UIImageView+GIF.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/9/11.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GIF)
//播放GIF
-(void)GIF_PrePlayWithImageNamesArray:(NSArray *)array duration:(NSInteger)duration;
//停止播放
-(void)GIF_Stop;
@end
