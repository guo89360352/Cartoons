//
//  PictureCollectionViewCell.h
//  Cartoon
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartoonModel.h"

@interface PictureCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic)UIImageView *MyImage;
@property (nonatomic,strong)UILabel * myTitle;

@property (nonatomic,strong)CartoonModel * model;

@property (nonatomic,strong)NSData * data;

@end
