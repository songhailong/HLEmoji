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
        self.backgroundColor=[UIColor greenColor];
        [self initUI];
    }
    return self;
}
-(void)initUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat with= self.frame.size.width;
    CGFloat  LineSpacing=(with-240)/5;
    layout.minimumLineSpacing =LineSpacing;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(20, LineSpacing, 0, LineSpacing);

    
    CGRect r = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _collView = [[UICollectionView alloc]initWithFrame:r collectionViewLayout:layout];
    [_collView registerClass:[AddViewHandleCell class] forCellWithReuseIdentifier:@"AddViewHandleCell"];
    //[_collView registerClass:[WXexpressionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELLHeader];
    _collView.delegate = self;
    _collView.dataSource = self;
    _collView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    _collView.backgroundColor = [UIColor clearColor];
    _collView.pagingEnabled=YES;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   return CGSizeMake(60, 80);
}
-(__kindof   UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddViewHandleCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AddViewHandleCell" forIndexPath:indexPath];
    cell.imageBn.image=[UIImage imageNamed:[self.dataArr objectAtIndex:indexPath.row]];
    cell.textLable.text=self.dataArr[indexPath.row];
    
    return cell;
}
-(void)handledidSelectAction:(handleComple)handleBlock{
    self.handleBlock=handleBlock;
}
-(NSArray*)dataArr{
    if (!_dataArr) {
        _dataArr=[[NSArray alloc] init];
        _dataArr=@[@"照片",@"拍摄",@"视频",@"位置",@"录像"];
    }
    return _dataArr;
}


@end
