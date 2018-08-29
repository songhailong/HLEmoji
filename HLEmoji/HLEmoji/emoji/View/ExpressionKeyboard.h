//
//  ExpressionKeyboard.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol ExpressionKeyboardDelegate<NSObject>
@optional
-(void)sendMessage:(NSString *)msg;
-(void)recordFinish:(NSURL *)url WithTime:(float)time;

-(void)selectImage;

//显示表情时应该处理高
- (void)handleHeight:(CGFloat)height;
@end
@interface ExpressionKeyboard : UIView
@property(nonatomic,assign)BOOL isOpend;
@property(nonatomic,weak)id<ExpressionKeyboardDelegate>delegate;
@property(nonatomic,strong)UIButton *recordImage;
@property(nonatomic,strong)UIButton *btnRecord;
@property (nonatomic, strong) NSURL *url;
/**
 录音
 */
@property(nonatomic,strong)AVAudioRecorder *recorder;
/**
 隐藏
 */
-(void)hide;
@end
