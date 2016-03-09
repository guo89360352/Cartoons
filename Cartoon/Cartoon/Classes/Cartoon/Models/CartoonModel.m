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
        self.name = dic[@"name"];
        
       // self.cartoonChapterList = dic[@"cartoonChapterList"];
//        self.chapterId = dic[@"cartoonChapterList"][@"id"];
//        self.chapterName = dic[@"cartoonChapterList"][@"name"];
//        self.totalChapterSize = dic[@"cartoonChapterList"][@"totalChapterSize"];
        self.author = dic[@"author"];
        self.creatTime = dic[@"createTime"];
        self.introduction = dic[@"introduction"];
        self.recentUpdateTime = dic[@"recentUpdateTime"];
        self.totalChapterCount = dic[@"totalChapterCount"];
        self.updateInfo = dic[@"updateInfo"];
        self.updateValue = dic[@"updateValueLabel"];
        self.content = dic[@"content"];
        self.informCount = dic[@"informCount"];
        self.imgHeight = dic[@"imgHeight"];
        self.imgWidth = dic[@"imgWidth"];
        self.size = CGSizeMake([dic[@"height"] floatValue], [dic[@"width"] floatValue]);
        
    }

    return self;
}


@end
