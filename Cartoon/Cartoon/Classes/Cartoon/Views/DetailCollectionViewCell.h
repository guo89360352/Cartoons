//
//  DetailCollectionViewCell.h
//  Cartoon
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *touImageV;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property(nonatomic, strong) UILabel *label;

@end
