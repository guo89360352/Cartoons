//
//  MyLayout.m
//  CollectTest
//
//  Created by chenliang on 15-7-9.
//  Copyright (c) 2015年 chenliang. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout
-(void)prepareLayout
{
    [super prepareLayout];
    self.delegate=(id<WaterFLayoutDelegate>)self.collectionView.delegate;
    
    self.sectionInset=[self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, MAX(leftY, rightY));
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    x=0;
    leftY=0;
    rightY=0;
    NSMutableArray *attributes=[NSMutableArray array];
    NSInteger allCount=[self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<allCount; i++) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath withIndex:i]];
    }
    return attributes;
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath withIndex:(NSInteger)index
{
    CGSize itemSize=[self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    index+=1;
    if (leftY<=rightY) {
        x=self.sectionInset.left;
        leftY+=self.sectionInset.top;
        attributes.frame=CGRectMake(x, leftY, itemSize.width,itemSize.height);
        leftY+=itemSize.height;
    }else{
        x=itemSize.width+self.sectionInset.left*3;
        rightY+=self.sectionInset.top;
        attributes.frame=CGRectMake(x, rightY, itemSize.width, itemSize.height);
        rightY+=itemSize.height;
    }
    return attributes;
}
@end
