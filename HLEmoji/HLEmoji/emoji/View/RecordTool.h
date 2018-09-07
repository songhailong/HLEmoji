//
//  RecordTool.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/9/7.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>
//语音录制信息回调
typedef void (^audioInfoCallback)(NSData *audioData,NSInteger seconds);
@interface RecordTool : NSObject
//初始化
+(instancetype)shareRecordTool;

/**
 开始录音
 */
-(void)beiganRecord;

/**
 取消录音
 */
-(void)cancelRecord;

/**
   结束录音
 */
-(void)stopRecord:(audioInfoCallback)infoCallbalck;

/**
 手指已开录音按钮
 */
-(void)moveOut;

/**
 继续录制
 */
-(void)continueRecord;
@end
