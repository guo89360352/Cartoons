//
//  MessageModel.m
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
-(instancetype)initWithDictionary:(NSDictionary *)dic rType:(NSString *)rtype{

    self = [super init];
    
    if (self) {
        self.rType = rtype;
        self.title = dic[@"title"];
        self.image_bg = dic[@"images"];
        self.pcId = dic[@"id"];
        

        if ([self.rType isEqualToString:@"adImage/list"]) {
           
            self.beginTime = dic[@"beginTime"];
            self.endTime = dic[@"endTime"];
            self.messageinfo = dic[@"messageinfo"];
            self.content = dic[@"messageinfo"][@"content"];
            self.images = self.messageinfo[@"images"];
            
        }else {
            
            self.author = dic[@"author"];
            self.creatTimeValue = dic[@"createTimeValue"];
            self.shareUrl = dic[@"shareUrl"];
            
        }
        
    }
    return self;

}
@end
