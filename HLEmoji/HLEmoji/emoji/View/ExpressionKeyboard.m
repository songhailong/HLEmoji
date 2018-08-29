//
//  ExpressionKeyboard.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "ExpressionKeyboard.h"
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height //屏高
static  NSString * const ChatKeyboardResign=@"ChatKeyboardResign";
@interface ExpressionKeyboard()<UITextViewDelegate>{
    UITextView *inputText;
    BOOL showFace;
    BOOL isKeyboard;
    NSArray* faceData;
    CGFloat   keyboardHeight;
}
@property(nonatomic,strong)UIButton *faceimage;
@property(nonatomic,strong)UIButton *addImg;
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
        
        CGFloat height=frame.size.height;
        CGFloat width=frame.size.width;
         self.recordImage=[UIButton new];
        //左边语音按钮
        [self.recordImage setImage:[UIImage imageNamed:@"语音"] forState:UIControlStateNormal];
        [self.recordImage setImage:[UIImage imageNamed:@"键盘" ] forState:UIControlStateSelected];
        self.recordImage.frame=CGRectMake(5, (height-30)/2.0, 30, 30);
        [self.recordImage addTarget:self action:@selector(recordKeyboardChange) forControlEvents:UIControlEventTouchUpInside];
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
        //self.btnRecord.layer.borderColor=RGB(218, 220, 220).CGColor;
        self.btnRecord.layer.borderColor=[UIColor colorWithRed:218/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
        self.btnRecord.layer.cornerRadius=6;
        self.btnRecord.hidden=true;
        [self.btnRecord setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.btnRecord addTarget:self action:@selector(recordUpAction) forControlEvents:UIControlEventTouchUpInside];
        [self.btnRecord addTarget:self action:@selector(recordDownAction) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.btnRecord];
        //表情按钮
        _faceimage=[[UIButton alloc] initWithFrame:CGRectMake(inputText.frame.size.width+inputText.frame.origin.x+5, (height-30)/2, 30, 30)];
        [_faceimage setBackgroundImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
         [_faceimage setBackgroundImage:[UIImage imageNamed:@"键盘"] forState:UIControlStateSelected];
        _faceimage.userInteractionEnabled=YES;
        UITapGestureRecognizer *faceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showFaceAction)];
        [_faceimage addGestureRecognizer:faceTap];
        [self addSubview:_faceimage];
        //加号按钮
        _addImg = [UIButton new];
        [_addImg setBackgroundImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
        _addImg.frame = CGRectMake(_faceimage.frame.size.height+_faceimage.frame.origin.x+5, (height-30)/2, 30, 30);
        _addImg.userInteractionEnabled = TRUE;
        UITapGestureRecognizer *addImgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImgAction)];
        [_addImg addGestureRecognizer:addImgTap];
        [self addSubview:_addImg];
        //键盘弹出通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //自定义键盘系统键盘降落
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardResignFirstResponder:) name:ChatKeyboardResign object:nil];
    }
    return self;
}
#pragma mark - 键盘降落
- (void)keyboardResignFirstResponder:(NSNotification *)note
{
//    [self.msgTextView resignFirstResponder];
//    //按钮初始化刷新
//    [self reloadSwitchButtons];
//    [self customKeyboardMove:SCREEN_HEIGHT - Height(self.messageBar.frame)];
}
- (void)systemKeyboardWillShow:(NSNotification *)note{
    //设置素有按钮的selects属性
    [self p_reloadSwitchButtons];
    //获取系统键盘高度
    CGFloat systemKbHeight  = [note.userInfo[@"UIKeyboardBoundsUserInfoKey"]CGRectValue].size.height;
    //记录系统键盘高度
    keyboardHeight = systemKbHeight;
    
    [self customKeyboardMove:SCREEN_HEIGHT-systemKbHeight-self.frame.size.height];
    
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
-(void)selectImgAction{
    
}
//显示表情键盘
-(void)showFaceAction{
    
}
-(void)recordKeyboardChange{
    
}
//
-(void)recordUpAction{
    
}
//
-(void)recordDownAction{
    
}
-(void)hide{
    //[self setBackgroundColor:];
}
@end
