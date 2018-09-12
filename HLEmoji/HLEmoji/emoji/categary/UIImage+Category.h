//
//  UIImage+Category.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
+(UIImage *)loadExpressionWithPathUrl:(NSString *)PathUrl;
+ (UIImage *)imageWithEmoji:(NSString *)emoji size:(CGFloat)size;
@end
