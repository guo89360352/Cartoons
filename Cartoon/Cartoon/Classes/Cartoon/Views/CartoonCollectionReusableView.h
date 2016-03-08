//
//  CartoonCollectionReusableView.h
//  Cartoon
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartoonModel.h"

@interface CartoonCollectionReusableView : UICollectionReusableView


@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) CartoonModel *model;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *gengxinLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;

@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIImageView *caverImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shouCangBtn;

@end
