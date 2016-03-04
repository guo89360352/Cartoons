//
//  MessageTableViewCell.m
//  Cartoon
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "MessageTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <CoreLocation/CoreLocation.h>

@interface MessageTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeValueLabel;


@end


@implementation MessageTableViewCell

-(void)setMessageModel:(MessageModel *)messageModel{

    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:messageModel.image_bg] placeholderImage:nil];
    self.authorLabel.text = messageModel.author;
    self.timeValueLabel.text = messageModel.creatTimeValue;
    self.titleLabel.text = messageModel.title;


}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
