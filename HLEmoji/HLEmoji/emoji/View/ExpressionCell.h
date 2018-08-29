//
//  ExpressionCell.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressionCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *ivImg;
- (void)loadData:(NSString*)imageName;

@end
