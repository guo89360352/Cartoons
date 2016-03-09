//
//  DetailCollectionViewCell.m
//  Cartoon
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "DetailCollectionViewCell.h"

@implementation DetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DetailCollectionViewCell" owner:self options:nil];
        
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
-(void)custums{
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
    
    
    label.textColor=[UIColor yellowColor];
    [self addSubview:label];
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
