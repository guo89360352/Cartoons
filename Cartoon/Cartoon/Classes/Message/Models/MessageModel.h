//
//  MessageModel.h
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (strong, nonatomic) NSString *pcId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image_bg;
@property (strong, nonatomic) NSString *beginTime;
@property (strong, nonatomic) NSString *endTime;

@property (strong, nonatomic) NSString *imageCount;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *keyWord;
@property (strong, nonatomic) NSString *introduction;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *shareContent;
@property (strong, nonatomic) NSString *shareUrl;
@property (strong, nonatomic) NSString *shoppingDate;
@property (strong, nonatomic) NSString *showTime;
@property (strong, nonatomic) NSString *creatTime;
@property (strong, nonatomic) NSString *creatTimeValue;
@property (strong, nonatomic) NSString *rType;


-(instancetype)initWithDictionary:(NSDictionary *)dic rType:(NSString *)rtype;

@end
