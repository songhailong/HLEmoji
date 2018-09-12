//
//  ExpressionKeyboard.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "ExpressionKeyboard.h"
#import "ExpressionInputView.h"
#import "ExpressionAddView.h"
#import "RecordTool.h"
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height //屏高
static  NSString * const ChatKeyboardResign=@"ChatKeyboardResign";
static float const FaceKeyboardHeight=224.0;
@interface ExpressionKeyboard()<UITextViewDelegate>{
    UITextView *inputText;
    BOOL showFace;
    BOOL isKeyboard;
    NSArray* faceData;
    CGFloat   keyboardHeight;
}
@property(nonatomic,strong)UIButton *faceimage;
@property(nonatomic,strong)UIButton *addImg;
//表情键盘
@property(nonatomic,strong)ExpressionInputView *faceKeyboard;
//加号键盘
@property(nonatomic,strong)ExpressionAddView *AddKeyboard;
//录音工具
@property(nonatomic,strong)RecordTool *recordTool;
@end
@implementation ExpressionKeyboard

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]];
        UIView *line=[UIView new];
        [line setBackgroundColor:[UIColor colorWithRed:218/255.0 green:220/255.0 blue:220/255.0 alpha:1]];
        line.frame=CGRectMake(0, 0, frame.size.width, 1);
        [self addSubview:line];
        
        CGFloat height=50;
        CGFloat width=frame.size.width;
         self.recordImage=[UIButton new];
         self.recordImage.frame=CGRectMake(5, (height-30)/2.0, 30, 30);
        //左边语音按钮
        [self.recordImage setImage:[UIImage imageNamed:@"语音"] forState:UIControlStateNormal];
        [self.recordImage setImage:[UIImage imageNamed:@"键盘" ] forState:UIControlStateSelected];
        [self.recordImage addTarget:self action:@selector(recordKeyboardChange:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.recordImage];
        //输入框
        inputText=[[UITextView alloc] init];
        inputText.frame=CGRectMake(self.recordImage.frame.size.width+5+5, (height-30)/2,width-(self.recordImage.frame.size.width+5+5)-75, 30);
        //inputText.layer.borderColor=RGB(218, 220, 220).CGColor;
        inputText.layer.borderColor=[UIColor colorWithRed:218/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
        inputText.layer.borderWidth=1;
        inputText.returnKeyType=UIReturnKeySend;
        inputText.layer.cornerRadius=6;
        inputText.delegate=self;
        [self addSubview:inputText];
        self.btnRecord=[UIButton new];
        [self.btnRecord setTitle:@"按住说话" forState:UIControlStateNormal];
        [self.btnRecord setTitle:@"松开结束" forState:UIControlStateHighlighted];
        self.btnRecord.frame=inputText.frame;
        self.btnRecord.layer.borderWidth=2;
        self.btnRecord.layer.borderColor=[UIColor colorWithRed:218/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
        self.btnRecord.layer.cornerRadius=6;
        self.btnRecord.hidden=true;
        [self.btnRecord setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //手指回到录音按钮 松开
        [self.btnRecord addTarget:self action:@selector(recordUpAction) forControlEvents:UIControlEventTouchUpInside];
       //按下录音按钮
        [self.btnRecord addTarget:self action:@selector(recordDownAction) forControlEvents:UIControlEventTouchDown];
        //手指离开录音按钮，但不松开
        [self.btnRecord addTarget:self action:@selector(audioLpButtonMoveOut:) forControlEvents:UIControlEventTouchDragExit|UIControlEventTouchDragOutside];
        //手指离开录音按钮，松开
        [self.btnRecord addTarget:self action:@selector(audioLpButtonMoveOutTouchUp:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchCancel];
        //手指回到录音按钮，但不松开
        [self.btnRecord addTarget:self
                           action:@selector(audioLpButtonMoveInside:) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDragEnter];
        
        
        [self addSubview:self.btnRecord];
        //表情按钮
        _faceimage=[[UIButton alloc] initWithFrame:CGRectMake(inputText.frame.size.width+inputText.frame.origin.x+5, (height-30)/2, 30, 30)];
        [_faceimage setBackgroundImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
         [_faceimage setBackgroundImage:[UIImage imageNamed:@"键盘"] forState:UIControlStateSelected];
        _faceimage.userInteractionEnabled=YES;
//        UITapGestureRecognizer *faceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showFaceAction)];
//        [_faceimage addGestureRecognizer:faceTap];
        [_faceimage addTarget:self action:@selector(showFaceAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_faceimage];
        //加号按钮
        _addImg = [UIButton new];
        [_addImg setBackgroundImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
        _addImg.frame = CGRectMake(_faceimage.frame.size.height+_faceimage.frame.origin.x+5, (height-30)/2, 30, 30);
        _addImg.userInteractionEnabled = TRUE;
//        UITapGestureRecognizer *addImgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImgAction)];
//        [_addImg addGestureRecognizer:addImgTap];
        [_addImg addTarget:self action:@selector(selectImgAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addImg];
        //键盘弹出通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //自定义键盘系统键盘降落
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardResignFirstResponder:) name:ChatKeyboardResign object:nil];
        [self initUI];
    }
    return self;
}
-(void)initUI{
    [self  addSubview:self.AddKeyboard];
    [self addSubview:self.faceKeyboard];
}
-(void)initBtnRecord{
    self.btnRecord=[UIButton new];
    [self.btnRecord setTitle:@"按住说话" forState:UIControlStateNormal];
    [self.btnRecord setTitle:@"松开结束" forState:UIControlStateHighlighted];
    self.btnRecord.frame=inputText.frame;
    self.btnRecord.layer.borderWidth=2;
    self.btnRecord.layer.borderColor=[UIColor colorWithRed:218/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.btnRecord.layer.cornerRadius=6;
    self.btnRecord.hidden=true;
    [self.btnRecord setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //手指回到录音按钮 松开
    [self.btnRecord addTarget:self action:@selector(recordUpAction) forControlEvents:UIControlEventTouchUpInside];
    //按下录音按钮
    [self.btnRecord addTarget:self action:@selector(recordDownAction) forControlEvents:UIControlEventTouchDown];
    //手指离开录音按钮，但不松开
    [self.btnRecord addTarget:self action:@selector(audioLpButtonMoveOut:) forControlEvents:UIControlEventTouchDragExit|UIControlEventTouchDragOutside];
    //手指离开录音按钮，松开
    [self.btnRecord addTarget:self action:@selector(audioLpButtonMoveOutTouchUp:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchCancel];
    //手指回到录音按钮，但不松开
    [self.btnRecord addTarget:self
                       action:@selector(audioLpButtonMoveInside:) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDragEnter];
    
    
   // [self addSubview:self.btnRecord];
}

#pragma mark - 键盘降落
- (void)keyboardResignFirstResponder:(NSNotification *)note
{     //键盘隐藏
    [inputText resignFirstResponder];
//    //按钮初始化刷新
  [self p_reloadSwitchButtons];
    [self customKeyboardMove:SCREEN_HEIGHT - self.frame.size.height];
}
- (void)systemKeyboardWillShow:(NSNotification *)note{
    //设置素有按钮的selects属性
    [self p_reloadSwitchButtons];
    //获取系统键盘高度
    CGFloat systemKbHeight  = [note.userInfo[@"UIKeyboardBoundsUserInfoKey"]CGRectValue].size.height;
    //记录系统键盘高度
    keyboardHeight = systemKbHeight;
    
    [self customKeyboardMove:SCREEN_HEIGHT-systemKbHeight-50];
    
}
-(void)p_reloadSwitchButtons{
    self.recordImage.selected=NO;
    self.addImg.selected=NO;
    self.faceimage.selected=NO;
}
#pragma mark - 自定义键盘位移变化
- (void)customKeyboardMove:(CGFloat)customKbY
{
    [UIView animateWithDuration:0.25 animations:^{
        //self.frame = Frame(0,customKbY, SCREEN_WITDTH, Height(self.frame));
        self.frame=CGRectMake(0, customKbY, self.frame.size.width, self.frame.size.height);
    }];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}
//加号按钮
-(void)selectImgAction:(UIButton *)btn{
    btn.selected=!btn.selected;
    //重置其他按钮select
    self.recordImage.selected=NO;
    self.faceimage.selected=NO;
    self.faceKeyboard.hidden=YES;
      keyboardHeight=224;
    if (btn.selected) {
        inputText.hidden=NO;
        self.btnRecord.hidden=YES;
        [inputText resignFirstResponder];
        self.AddKeyboard.hidden=NO;
        [UIView animateWithDuration:5 animations:^{
            self.AddKeyboard.frame=CGRectMake(0, 50,self.frame.size.width, self->keyboardHeight);
            //self.AddKeyboard.transform=CGAffineTransformMakeTranslation(0, 50);
        }];
         [self customKeyboardMove:SCREEN_HEIGHT-self.frame.size.height];
    }else{
        self.AddKeyboard.hidden=YES;
        [inputText becomeFirstResponder];
    }
}
//显示表情键盘
-(void)showFaceAction:(UIButton *)btn{
    btn.selected=!btn.selected;
    //重置其他按钮select
    self.recordImage.selected=NO;
    self.addImg.selected=NO;
    self.AddKeyboard.hidden=YES;
    keyboardHeight=224;
    if (btn.selected) {
        inputText.hidden=NO;
        self.btnRecord.hidden=YES;
        [inputText resignFirstResponder];
        self.faceKeyboard.hidden=NO;
        [self bringSubviewToFront:self.faceKeyboard];
        [UIView animateWithDuration:0.5 animations:^{
            //self.faceKeyboard.frame=CGRectMake(0, 50,self.frame.size.width, keyboardHeight);
            //self.faceKeyboard.transform=CGAffineTransformMakeTranslation(0, 50);
        }];
        [self customKeyboardMove:SCREEN_HEIGHT-self.frame.size.height];
    }else{
        self.faceKeyboard.hidden=YES;
        [inputText becomeFirstResponder];
    }
    
}
//左边按钮
-(void)recordKeyboardChange:(UIButton *)btn{
    btn.selected=!btn.selected;
    self.faceimage.selected=NO;
    self.addImg.selected=NO;
    if (btn.selected) {
        //[self.recordImage setImage:[UIImage imageNamed:@"键盘"] forState:UIControlStateNormal];
        self.btnRecord.hidden=NO;
        inputText.hidden=YES;
        [self hide];
        self.isOpend=NO;
        self.AddKeyboard.hidden=YES;
        self.faceKeyboard.hidden=YES;
        [self customKeyboardMove:SCREEN_HEIGHT-50];
    }else{
        [inputText becomeFirstResponder];
        //[self.recordImage setImage:[UIImage imageNamed:@"语音"] forState:UIControlStateNormal];
        self.btnRecord.hidden=YES;
        inputText.hidden=NO;
        self.isOpend=YES;
    }
    
}

//结束录音
-(void)recordUpAction{
    NSLog(@"这里执行");
    
    [self.recordTool stopRecord:^(NSData *audioData, NSInteger seconds) {
        NSLog(@"录制时长时长%zd",seconds);
    }];
    self.recordTool=nil;
}

/**
 开始录音
 */
-(void)recordDownAction{
    
    [self.recordTool beiganRecord];
//    __weak typeof (self)weakself=self;
//    [self.recordTool completeRecord:^(NSData *audioData, NSInteger seconds) {
//         NSLog(@"录制时长时长%zd",seconds);
//      weakself.recordTool=nil;
//    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeRecord) name:@"completeRecord" object:nil];
    
}
-(void)completeRecord{
    [self.btnRecord sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self initBtnRecord];
   // [self recordUpAction];
}
#pragma mark*******手指离开录音按钮，但不松开
-(void)audioLpButtonMoveOut:(UIButton *)audioLpButton{
    [self.recordTool moveOut];
}
#pragma mark*******手指离开录音按钮 松开
-(void)audioLpButtonMoveOutTouchUp:(UIButton *)audioLpButton{
    [self.recordTool cancelRecord];
    //释放蒙版
    self.recordTool=nil;
}
#pragma mark*******手指回到录音按钮，但不松开
-(void)audioLpButtonMoveInside:(UIButton *)audioLpButton{
    [self.recordTool continueRecord];
}
-(void)hide{
    //[self setBackgroundColor:];
    //结束第一响应
    [inputText endEditing:YES];
    self.isOpend=NO;
    [self hideFaceAnimation];
}
-(void)hideFaceAnimation{
    
}
#pragma mark*******懒加载
-(ExpressionInputView *)faceKeyboard{
    if (!_faceKeyboard) {
        _faceKeyboard=[[ExpressionInputView alloc] init];
        _faceKeyboard.hidden=YES;
    }
    return _faceKeyboard;
}
-(ExpressionAddView *)AddKeyboard{
    if (!_AddKeyboard) {
        _AddKeyboard=[[ExpressionAddView alloc] init];
        _AddKeyboard.hidden=YES;
    }
    return _AddKeyboard;
}
-(RecordTool *)recordTool{
    if (!_recordTool) {
        //NSLog(@"执行===执行");
        _recordTool=[RecordTool shareRecordTool];
    }
    return _recordTool;
}
-(void)layoutSubviews{
    [super layoutSubviews];
       self.faceKeyboard.frame=CGRectMake(0,50, self.frame.size.width, FaceKeyboardHeight);
    self.AddKeyboard.frame=CGRectMake(0, 50, self.frame.size.width, FaceKeyboardHeight);
}
@end
