//
//  ExpressionInputView.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "ExpressionInputView.h"
#import "ExpressionCell.h"
#import "Emoticon.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static NSString * const  CELLIDEN=@"cell";
static NSString * const  CELLHeader=@"Header";
static CGFloat emotionH =50;
@interface  ExpressionInputView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (nonatomic, strong) UIView *vTopBg;
@property(nonatomic,strong)UICollectionView *collView;
@property(nonatomic,strong)UIPageControl * PageControl;
@property (nonatomic, strong) NSMutableArray <EmoticonGroup *>*emojiDictionary;
@property (nonatomic, strong) UIView *vDownBg;
@property (nonatomic, strong) UIButton *btnSend;
@property (nonatomic, strong) UIButton *btnDefault;
@property (nonatomic, strong) UIButton *btnEmoji;
@property (nonatomic, strong) UIButton *btnflower;
@property (nonatomic, strong) UIView *vHorLine;
@property (nonatomic, strong) UIView *vLineOne;
@property (nonatomic, strong) UIView *vLineTwo;
@property (nonatomic, strong) NSArray<NSNumber *> *emoticonGroupPageIndexs;
@property (nonatomic, strong) NSArray<NSNumber *> *emoticonGroupPageCounts;
@property (nonatomic, assign) NSInteger emoticonGroupTotalPageCount;
@property (nonatomic, assign) NSInteger currentPageIndex;
@end
@implementation ExpressionInputView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
        //self.backgroundColor=[UIColor redColor];
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    _vTopBg = [[UIView alloc]init];
    [self addSubview:_vTopBg];
    //[self addSubview:self.collView];
    _vDownBg = [[UIView alloc]init];
    _vDownBg.backgroundColor = [UIColor whiteColor];
    [self addSubview:_vDownBg];
    [_vDownBg addSubview:self.btnEmoji];
    [_vDownBg addSubview:self.btnDefault];
    [_vDownBg addSubview:self.btnflower];
    _vHorLine = [[UIView alloc]init];
    _vHorLine.backgroundColor = [UIColor blackColor];
    _vHorLine.alpha = 0.3;
    [_vDownBg addSubview:_vHorLine];
    
    _vLineOne = [[UIView alloc]init];
    _vLineOne.backgroundColor = [UIColor blackColor];
    _vLineOne.alpha = 0.3;
    [_vDownBg addSubview:_vLineOne];
    
    _vLineTwo = [[UIView alloc]init];
    _vLineTwo.backgroundColor = [UIColor blackColor];
    _vLineTwo.alpha = 0.3;
    [_vDownBg addSubview:_vLineTwo];
}
#pragma mark*********代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
EmoticonGroup *mog=[_emojiDictionary objectAtIndex:indexPath.section];
    Emoticon *emo=mog.emoticons[indexPath.row];
    NSLog(@"是否删除%d=======imagepath%@======emotionStr%@",emo.isRemove,emo.imagePath,emo.emotionStr);
    //NSString *face = [self.emojiDictionary objectAtIndex:indexPath.row];
   /// [_delegate selectWithExpression:face];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.emojiDictionary.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_emojiDictionary.count) {
        EmoticonGroup *group=[_emojiDictionary objectAtIndex:section];
        
        //NSLog(@"%zd",group.emoticons.count);
        
        return group.emoticons.count;
    }else{
      return 0;
    }
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(40, 40);
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   ExpressionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CELLIDEN forIndexPath:indexPath];
    
    EmoticonGroup *group=[self.emojiDictionary objectAtIndex:indexPath.section];
    Emoticon *emo=[group.emoticons objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor greenColor];
    cell.emoticon=emo;
    //[cell loadData:imagePath];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page=round(scrollView.contentOffset.x/scrollView.frame.size.width);
    
    NSLog(@"%zd页数------%f---",page,scrollView.contentOffset.x,scrollView.contentOffset.y);
    
    NSIndexPath *indexpath=[_collView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
   NSInteger  cuntpage= indexpath.row/21;
    EmoticonGroup *group=_emojiDictionary[indexpath.section];
    self.PageControl.numberOfPages=group.numberOfPage;
    self.PageControl.currentPage=cuntpage;
    //if (page<0)page=0 ;
    //else if (page>=)
    
}
-(void)movetoToolBarnWith{
    
}
#pragma mark*******按钮
-(void)sendAction{
    
}
-(void)flowerAction{
    
}
-(void)emojiAction{
    
}
#pragma mark********懒加载
-(UICollectionView*)collView{
    if (!_collView) {
        
        CGFloat itemWith=(SCREEN_WIDTH-10*2)/7.0;
        CGFloat paddingLeft=(SCREEN_WIDTH-7*itemWith)/2.0;
        CGFloat paddingRight=SCREEN_WIDTH-paddingLeft-itemWith*7;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize=CGSizeMake(itemWith, emotionH);
        //行间距
        layout.minimumLineSpacing = 0;
        //列间距
        layout.minimumInteritemSpacing =0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        CGRect r = CGRectMake(10, 0, self.frame.size.width-20, emotionH*3);
        _collView = [[UICollectionView alloc]initWithFrame:r collectionViewLayout:layout];
        [_collView registerClass:[ExpressionCell class] forCellWithReuseIdentifier:CELLIDEN];
        //[_collView registerClass:[WXexpressionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELLHeader];
        _collView.delegate = self;
        _collView.dataSource = self;
        //_collView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        _collView.backgroundColor = [UIColor whiteColor];
        _collView.pagingEnabled=YES;
        _collView.bounces=NO;
        _collView.showsHorizontalScrollIndicator=NO;
       //_collView.clipsToBounds=NO;
        _collView.canCancelContentTouches=NO;
//        _collView.multipleTouchEnabled=NO;
        
    }
    return _collView;
}
//发送
-(UIButton *)btnSend{
    if (!_btnSend) {
        _btnSend = [[UIButton alloc]init];
        [_btnSend setTitle:@"发送" forState:UIControlStateNormal];
        _btnSend.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnSend setTitleColor:[UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1] forState:UIControlStateNormal];
        [_btnSend addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSend;
}
-(UIButton *)btnDefault{
    if (!_btnDefault) {
        _btnDefault = [[UIButton alloc]init];
        [_btnDefault setTitle:@"默认" forState:UIControlStateNormal];
        _btnDefault.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnDefault setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnDefault.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1];
    }
    return _btnDefault;
}
-(UIButton *)btnEmoji{
    if (!_btnEmoji) {
        _btnEmoji = [[UIButton alloc]init];
        [_btnEmoji setTitle:@"Emoji" forState:UIControlStateNormal];
        _btnEmoji.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnEmoji setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnEmoji.backgroundColor =[UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1];
        [_btnEmoji addTarget:self action:@selector(emojiAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnEmoji;
}
-(UIButton *)btnflower{
    if (!_btnflower) {
        _btnflower = [[UIButton alloc]init];
        [_btnflower setTitle:@"小花" forState:UIControlStateNormal];
        _btnflower.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnflower setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnflower.backgroundColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1];
        [_btnflower addTarget:self action:@selector(flowerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnflower;
}
-(NSMutableArray *)emojiDictionary{
    if (!_emojiDictionary) {
        _emojiDictionary=[[NSMutableArray alloc] init];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
           NSString *emoticonBundlePath = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"bundle"];
        NSString *emoticonPlistPath = [emoticonBundlePath stringByAppendingPathComponent:@"emoticons.plist"];
       NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:emoticonPlistPath];
        NSArray *package=plist[@"packages"];
            for (NSDictionary *dic in package) {
                EmoticonGroup *group=[[EmoticonGroup alloc] init];
                group.groupID=[dic objectForKey:@"id"];
                group.version=[dic objectForKey:@"version"];
                group.displayOnly=[dic objectForKey:@"display_only"];
                NSString *emoticonGroupidpatn=[[emoticonBundlePath stringByAppendingPathComponent:group.groupID] stringByAppendingPathComponent:@"info.plist"];
                NSDictionary *info=[NSDictionary dictionaryWithContentsOfFile:emoticonGroupidpatn];
               // NSLog(@"%@",info);
                group.nameCN=[info objectForKey:@"group_name_cn"];
                group.nameTW=[info objectForKey:@"group_name_tw"];
                group.nameEN=[info objectForKey:@"group_name_en"];
                NSArray *emotions=[info objectForKey:@"emoticons"];
                NSMutableArray *motionArr=[[NSMutableArray alloc] init];
                NSInteger index=0;
                for (NSDictionary * emotiondDic in emotions) {
                    
                    if (index==20) {
                        index=0;
                        Emoticon*emotion=[[Emoticon alloc] init];
                        emotion.isRemove=YES;
                         [motionArr addObject:emotion];
                    }
                    
                    Emoticon *emotion=[Emoticon initwithDic:emotiondDic];
                    emotion.groupid=group.groupID;
                    emotion.imagePath=[[emoticonBundlePath stringByAppendingPathComponent:group.groupID] stringByAppendingPathComponent:emotion.png];
                   [motionArr addObject:emotion];
                    index++;
                }
                group.emoticons=motionArr;
                [self.emojiDictionary  addObject:group];
            }
        });
    }
    return _emojiDictionary;
}
-(NSInteger)emoticonGroupTotalPageCount{
    if (!_emoticonGroupTotalPageCount) {
        for (EmoticonGroup *goup in self.emojiDictionary) {
            _emoticonGroupTotalPageCount=_emoticonGroupTotalPageCount+goup.numberOfPage;
        }
    }
    return _emoticonGroupTotalPageCount;
}
-(UIPageControl *)PageControl{
    if (!_PageControl) {
        _PageControl=[[UIPageControl alloc] init];
        //_PageControl.hidesForSinglePage=YES;
        _PageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
        _PageControl.pageIndicatorTintColor=[UIColor grayColor];
    }
    return _PageControl;
}
//布局
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat withH=self.frame.size.width;
    CGRect rect=self.vTopBg.frame;
    rect.origin.x=0;
    rect.origin.y=0;
    rect.size.width=self.frame.size.width;
    rect.size.height=self.frame.size.height-40;
    self.vTopBg.frame=rect;
    
    rect=self.collView.frame;
    NSLog(@"%@",NSStringFromCGRect(rect));
    rect.origin.x=0;
    rect.origin.y=0;
    rect.size.width=self.vTopBg.frame.size.width;
    rect.size.height=self.vTopBg.frame.size.height;
    //self.collView.frame=rect;
    
    rect=self.vDownBg.frame;
    rect.origin.x=0;
    rect.origin.y=self.frame.size.height-40;
    rect.size.width=self.vTopBg.frame.size.width;
    rect.size.height=40;
    self.vDownBg.frame=rect;
    
    rect=self.btnSend.frame;
    rect.origin.x=self.frame.size.width-50*RATIO_WIDHT320;
    rect.origin.y=0;
    rect.size.width=50*RATIO_WIDHT320;
    rect.size.height=self.vDownBg.frame.size.height;
    self.btnSend.frame=rect;
    //线条
    CGFloat w = (self.frame.size.width - self.btnSend.frame.size.width - 2)/3.0;
    rect = self.vHorLine.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    rect.size.width = withH - self.btnSend.frame.size.width;
    rect.size.height = w;
    self.vHorLine.frame = rect;
    
   CGRect  r = self.btnDefault.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.vDownBg.frame.size.height;
    self.btnDefault.frame = r;
    
    r = self.vLineOne.frame;
    r.origin.x = self.btnDefault.frame.size.width;
    r.origin.y = 0;
    r.size.width = 1;
    r.size.height = self.vDownBg.frame.size.height;
    self.vLineOne.frame = r;
    
    r = self.btnEmoji.frame;
    r.origin.x = self.vLineOne.frame.origin.x+self.vLineOne.frame.size.width;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.vDownBg.frame.size.height;
    self.btnEmoji.frame = r;
    
    r = self.vLineOne.frame;
    r.origin.x = self.btnDefault.frame.origin.x+self.btnDefault.frame.size.width;
    r.origin.y = 0;
    r.size.width = 1;
    r.size.height = self.vDownBg.frame.size.height;
    self.vLineOne.frame = r;
    
    r = self.btnflower.frame;
    r.origin.x = self.btnEmoji.frame.origin.x+self.btnEmoji.frame.size.width;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.vDownBg.frame.size.height;
    self.btnflower.frame = r;
    [self addSubview:self.collView];
    
    r=self.collView.frame;
    self.PageControl.frame=CGRectMake(0, self.collView.frame.size.height+5, SCREEN_WIDTH, 20);
    self.PageControl.currentPage=0;
    self.PageControl.numberOfPages=self.emojiDictionary[0].numberOfPage;
    [self addSubview:self.PageControl];
    
}


@end
