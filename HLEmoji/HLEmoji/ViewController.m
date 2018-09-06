//
//  ViewController.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "ViewController.h"
#import "ExpressionKeyboard.h"
@interface ViewController ()<ExpressionKeyboardDelegate>
@property(nonatomic,strong)ExpressionKeyboard *inputView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.inputView];
    self.inputView.delegate=self;
}
-(ExpressionKeyboard *)inputView{
    if (!_inputView) {
        CGRect fream=self.view.frame;
        CGFloat height=fream.size.height;
        CGFloat With=fream.size.width;
        _inputView=[[ExpressionKeyboard alloc] initWithFrame:CGRectMake(0, height-50, With, 273)];
        
    }
    return _inputView;
}
-(void)sendMessage:(NSString *)msg{
    
}
-(void)recordFinish:(NSURL *)url WithTime:(float)time{
    
}

-(void)selectImage{
    
}

//显示表情时应该处理高
- (void)handleHeight:(CGFloat)height{
    
}

@end
