//
//  UIImageView+GIF.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/9/11.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "UIImageView+GIF.h"

@implementation UIImageView (GIF)

-(void)GIF_PrePlayWithImageNamesArray:(NSArray *)array duration:(NSInteger)duration{


self.hidden = NO;
NSMutableArray *arr = [NSMutableArray array];
[array enumerateObjectsUsingBlock:^(NSString  *_Nonnull imageName, NSUInteger idx, BOOL * _Nonnull stop) {
    
    UIImage *image = [UIImage imageNamed:imageName];
    [arr addObject:image];
}];
//设置序列帧图像数组
self.animationImages = arr;
//设置动画时间
self.animationDuration = 1;
//设置播放次数，0代表无限次
self.animationRepeatCount = (NSInteger)duration;
[self startAnimating];
}
//停止播放
- (void)GIF_Stop
{
    [self stopAnimating];
}
@end
