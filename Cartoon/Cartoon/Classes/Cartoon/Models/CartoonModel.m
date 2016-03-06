//
//  CartoonModel.m
//  Cartoon
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "CartoonModel.h"

@implementation CartoonModel
-(instancetype)initWithDic:(NSDictionary *)dic{

    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.content = dic[@"content"];
        self.imageUrl = dic[@"images"];
        self.cartoonsId = dic[@"id"];
    }

    return self;
}


@end
