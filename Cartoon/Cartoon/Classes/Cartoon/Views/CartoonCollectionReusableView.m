//
//  CartoonCollectionReusableView.m
//  Cartoon
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "CartoonCollectionReusableView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CartoonCollectionReusableView
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
//-(void)setModel:(CartoonModel *)model{
//
//    self.imageView = [[UIImageView alloc] initWithFrame:self.frame];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
//    [self addSubview:self.imageView];
//
//
//}
- (void)awakeFromNib {
    // Initialization code
}

@end
