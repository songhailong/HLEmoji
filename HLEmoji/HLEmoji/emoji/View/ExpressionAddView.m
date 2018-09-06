//
//  ExpressionAddView.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "ExpressionAddView.h"
#import "AddViewHandleCell.h"
@interface  ExpressionAddView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collView;
@property(nonatomic,strong)NSArray *dataArr;
@end
@implementation ExpressionAddView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //self.backgroundColor=[UIColor greenColor];
        //self.userInteractionEnabled=NO;
        [self initUI];
    }
    return self;
}
-(void)initUI{
    CGRect r = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
   // [UIScreen mainScreen].bounds.size.width;
    CGFloat with=[UIScreen mainScreen].bounds.size.width ;
    CGFloat  LineSpacing=(with-240)/5;
    layout.minimumLineSpacing =20;
    layout.minimumInteritemSpacing =LineSpacing ;
   layout.sectionInset = UIEdgeInsetsMake(20, LineSpacing, 20, LineSpacing);
   // self.autoresizesSubviews=YES;
    //self.au
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    _collView = [[UICollectionView alloc]initWithFrame:r collectionViewLayout:layout];
    [_collView registerClass:[AddViewHandleCell class] forCellWithReuseIdentifier:@"AddViewHandleCell"];
    //[_collView registerClass:[WXexpressionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELLHeader];
    _collView.backgroundColor=[UIColor greenColor];
    _collView.delegate = self;
    _collView.dataSource = self;
    //_collView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    _collView.backgroundColor = [UIColor clearColor];
    //_collView.pagingEnabled=YES;
    [self addSubview:_collView];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     NSLog(@"cccc-----------%zd",self.dataArr.count);
    return self.dataArr.count;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   return CGSizeMake(60, 80);
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddViewHandleCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AddViewHandleCell" forIndexPath:indexPath];
    cell.imageBn.image=[UIImage imageNamed:[self.dataArr objectAtIndex:indexPath.row]];
    //cell.backgroundColor=[UIColor greenColor];
    cell.textLable.text=self.dataArr[indexPath.row];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            self.keyType=handleKeyTypePhoto;
            break;
        case 1:
            self.keyType=handleKeyTypeVideo;
            break;
        case 2:
            self.keyType=handleKeyTypeCamera;
            break;
        case 3:
            self.keyType=handleKeyTypeFile;
            break;
        case 4:
            self.keyType=handleKeyTypAderess;
            break;
        case 5:
            self.keyType=handleKeyTypeIphne;
            break;
            
            
        default:
            break;
    }
    if (_handleBlock) {
        _handleBlock(_keyType);
    }
}
-(void)handledidSelectAction:(handleComple)handleBlock{
    self.handleBlock=handleBlock;
}
-(NSArray*)dataArr{
    if (!_dataArr) {
        _dataArr=[[NSArray alloc] init];
        _dataArr=@[@"照片",@"拍摄",@"视频",@"位置",@"录像",@"通话"];
    }
    return _dataArr;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _collView.frame=r;
    //_collView.backgroundColor=[UIColor redColor];
}

@end
