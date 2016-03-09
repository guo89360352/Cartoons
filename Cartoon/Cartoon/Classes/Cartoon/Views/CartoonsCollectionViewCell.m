//
//  CartoonsCollectionViewCell.m
//  Cartoon
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "CartoonsCollectionViewCell.h"

@implementation CartoonsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CartoonsCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}
-(void)custum{

}

- (void)awakeFromNib {
    // Initialization code
}

@end
