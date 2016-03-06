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



-(instancetype)initWithDic:(NSDictionary *)dic;

@end
