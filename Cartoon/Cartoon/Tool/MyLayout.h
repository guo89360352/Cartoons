//
//  MyLayout.h
//  CollectTest
//
//  Created by chenliang on 15-7-9.
//  Copyright (c) 2015年 chenliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WaterFLayoutDelegate<NSObject>
@required
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
@end
@interface MyLayout : UICollectionViewLayout
{
    float x;
    float leftY;
    float rightY;
}
@property(nonatomic,assign)UIEdgeInsets sectionInset;
@property(nonatomic,weak)id<WaterFLayoutDelegate> delegate;

@end
