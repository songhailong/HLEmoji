//
//  RecordTool.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/9/7.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "RecordTool.h"
#import "Mp3Recorder.h"
#import "UIImageView+GIF.h"
#import <UIKit/UIKit.h>
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH
@interface RecordTool()<Mp3RecorderDelegate>
/**定时器*/
@property(nonatomic,strong)dispatch_source_t recordTimer;
/**蒙版*/
@property(nonatomic,strong)UIView *recordCoverView;
/**展示*/
@property (nonatomic, strong) UIImageView *animationView;
/**倒计时*/
@property (nonatomic, strong) UILabel *cutdownLabel;
/**录音*/
@property (nonatomic, strong) Mp3Recorder *recorder;
//录制的秒数
@property (nonatomic, assign) NSUInteger recordSeconds;
@property(nonatomic,copy)audioInfoCallback infoCallblock;
@end
@implementation RecordTool
#pragma mark********懒加载
-(dispatch_source_t)recordTimer{
    if (!_recordTimer) {
        _recordTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_recordTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    }
    return _recordTimer;
}
-(Mp3Recorder *)recorder{
    if (!_recorder) {
        _recorder=[[Mp3Recorder alloc] initWithDelegate:self];
    }
    return _recorder;
}
-(UIView *)recordCoverView{
    if (!_recordCoverView) {
        _recordCoverView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _recordCoverView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
        _recordCoverView.userInteractionEnabled=NO;
        [_recordCoverView addSubview:self.animationView];
        [_recordCoverView addSubview:self.cutdownLabel];
    }
    return _recordCoverView;
}
-(UIImageView *)animationView{
    if (!_animationView) {
        CGFloat with=[UIScreen mainScreen].bounds.size.width;
        _animationView=[[UIImageView alloc] initWithFrame:CGRectMake((with-120)*0.5, (SCREEN_HEIGHT-120)*0.5, 120, 120)];
    }
    return _animationView;
}
-(UILabel *)cutdownLabel{
    if (!_cutdownLabel) {
        _cutdownLabel=[[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-120)*0.5, (SCREEN_HEIGHT-120)*0.5, 120, 120)];
        _cutdownLabel.font=[UIFont systemFontOfSize:50 weight:0.2];
        _cutdownLabel.textColor=[UIColor whiteColor];
        _cutdownLabel.textAlignment = NSTextAlignmentCenter;
        _cutdownLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        _cutdownLabel.layer.cornerRadius=10;
        _cutdownLabel.hidden = YES; //默认隐藏
    }
    return _cutdownLabel;
}
+(instancetype)shareRecordTool{
    return [[self alloc] init];
}
#pragma mark******方法实现
-(void)beiganRecord{
    //开始录制
    [self.recorder startRecord];
    UIWindow *keyWindow=[UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.recordCoverView];
    // 展示录音动画  0代表无限次数
    [self.animationView GIF_PrePlayWithImageNamesArray:@[@"正发送语音1",@"正发送语音2",@"正发送语音3"] duration:0];
    //开启定时器
    dispatch_source_set_event_handler(self.recordTimer, ^{
        
        _recordSeconds ++ ;
        //处理倒计时UI
        NSLog(@"=============%zd",_recordSeconds);
        if (_recordSeconds>50) {
            //[self.recorder stopRecord];
            //[self clearRecord];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"completeRecord" object:nil];
        }
        
    });
    dispatch_resume(self.recordTimer);
}
-(void)completeRecord:(audioInfoCallback)infoCallbalck{
    //_infoCallblock=infoCallbalck;
}
//取消
-(void)cancelRecord{
    [self.recorder cancelRecord];
    [self clearRecord];
}
-(void)stopRecord:(audioInfoCallback)infoCallbalck{
    _infoCallblock=infoCallbalck;
    [self.recorder stopRecord];
    [self clearRecord];
}
-(void)moveOut{
    if (_recordSeconds>50) {
        
    }else{
        [self.animationView GIF_Stop];
        [self.animationView  setImage:[UIImage imageNamed:@"松开取消发送"]];
    }
}
-(void)continueRecord{
    //播放GIF
    [self.animationView GIF_PrePlayWithImageNamesArray:@[@"正发送语音1",@"正发送语音2",@"正发送语音3"] duration:0];
}

//录音结束的代理
-(void)endConvertWithData:(NSData *)voiceData seconds:(NSTimeInterval)time{
    if(_infoCallblock){
        _infoCallblock(voiceData,(NSInteger)time);
        
    }
}
//清除录音
-(void)clearRecord{
    [UIView animateWithDuration:0.25 animations:^{
        self.recordCoverView.alpha=0.0001;
    } completion:^(BOOL finished) {
        //移除
        [self.recordCoverView removeFromSuperview];
        //关闭定时器
        dispatch_source_cancel(self.recordTimer);
    }];
}
- (void)dealloc
{
    dispatch_source_cancel(_recordTimer);
}

@end
