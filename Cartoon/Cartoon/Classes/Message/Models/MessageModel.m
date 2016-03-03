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
        if ([self.rType isEqualToString:@"adImage/list"]) {
           
            self.beginTime = dic[@"beginTime"];
            self.image_bg = dic[@"images"];
            self.endTime = dic[@"endTime"];
            
        }else {
           self.imageCount = dic[@"imageCount"];
            self.author = dic[@"author"];
          self.keyWord = dic[@"keyword"];
          self.introduction = dic[@"introduction"];
            self.label = dic[@"label"];
            self.shareContent = dic[@"shareContent"];
           self.shareUrl = dic[@"shareUrl"];
       self.shoppingDate = dic[@"shoppingDate"];
            self.showTime = dic[@"showTime"];
        self.creatTime = dic[@"creatTime"];
         self.creatTimeValue = dic[@"creatTimeValue"];
            
        }
         self.title = dic[@"title"];
        
        self.pcId = dic[@"id"];

    }
    return self;

}
@end
