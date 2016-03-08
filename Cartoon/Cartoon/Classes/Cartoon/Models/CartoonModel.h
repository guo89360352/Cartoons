//
//  CartoonModel.h
//  Cartoon
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartoonModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *cartoonsId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *creatTime;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *recentUpdateTime;
@property (nonatomic, strong) NSString *totalChapterCount;
@property (nonatomic, strong) NSString *updateInfo;
@property (nonatomic, strong) NSString *updateValue;
@property (nonatomic, strong) NSString *chapterId;
@property (nonatomic, strong) NSString *chapterName;
@property (nonatomic, strong) NSString *totalChapterSize;
@property (nonatomic, strong) NSArray *cartoonChapterList;



-(instancetype)initWithDic:(NSDictionary *)dic;

@end
