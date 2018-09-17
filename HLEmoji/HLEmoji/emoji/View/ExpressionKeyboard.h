//
//  ExpressionKeyboard.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ExpreessionHeader.h"



@protocol ExpressionKeyboardDelegate<NSObject>
@optional

/**
发送文字消息
 */
-(void)sendMessage:(NSString *)msg;


/**
 
  需要发送数据的点击
 
 */
@optional
-(void)sendMediaDidWithKeyType:(handleKeyType)mediaType;

/**
 录音完成
 */
@optional
-(void)sendVoiceDidWithData:(NSData *)videoData timeLenght:(NSInteger)timeLenght;
-(void)recordFinish:(NSURL *)url WithTime:(float)time;

-(void)selectImage;

//显示表情时应该处理高
- (void)handleHeight:(CGFloat)height;
@end
@interface ExpressionKeyboard : UIView
@property(nonatomic,assign)BOOL isOpend;
@property(nonatomic,weak)id<ExpressionKeyboardDelegate>delegate;
/**录音键盘切换*/
@property(nonatomic,strong)UIButton *recordImage;
/**长按录音按钮*/
@property(nonatomic,strong)UIButton *btnRecord;
@property (nonatomic, strong) NSURL *url;

/**输入最大行数*/
@property(nonatomic,assign)int maxNumberOfRowsToShow;
/**
 录音
 */
@property(nonatomic,strong)AVAudioRecorder *recorder;
/**
 隐藏
 */
-(void)hide;
@end
