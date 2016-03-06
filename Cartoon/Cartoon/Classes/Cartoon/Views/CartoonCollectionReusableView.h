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


@end
