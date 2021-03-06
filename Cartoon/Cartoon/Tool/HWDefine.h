//
//  HWDefine.h
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#ifndef HWDefine_h
#define HWDefine_h
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CartoonsType) {
   CartoonsTypeRecommend = 0,
   CartoonsTypeList,
   CartoonsTypeCategory,
};


//http://api.playsm.com/index.php?chapterId=9410&isSize=1&page=1&orderType=1&r=cartoonChapter%2FalbumList&size=10&

//http://api.playsm.com/index.php?chapterId=10158&isSize=1&page=1&orderType=1&r=cartoonChapter%2FalbumList&size=10&
//http://api.playsm.com/index.php?chapterId=10801&isSize=1&page=1&orderType=1&r=cartoonChapter%2FalbumList&size=10&
//http://api.playsm.com/index.php?chapterId=8995&isSize=1&page=1&orderType=1&r=cartoonChapter%2FalbumList&size=10&



#define kCapter @"http://api.playsm.com/index.php?isSize=1&page=1&orderType=1&r=cartoonChapter%2FalbumList&size=10&"

//chapterId=8995&
#define kCartoons @"http://api.playsm.com/index.php?&r=cartoonSet%2Fdetail&"
//id=325
#define kMessage @"http://api.playsm.com/index.php?page=1&r=adImage%2Flist&customPosition=1&size=999&"

#define kM @"http://api.playsm.com/index.php?page=1&r=message%2Flist&size=10&"
#define kMe @"http://api.playsm.com/index.php"
#define kPrrttyPic @"http://api.playsm.com/index.php?r=prettyImages%2FgetLabelList&"

#define kCartoon @"http://api.playsm.com/index.php?page=1"
//&r=recommend%2FgetUserRecommendList&size=999

//ad
#define kAd @"http://api.playsm.com/index.php?page=1&r=adImage%2Flist&customPosition=2&size=999&"


#define kZuijin @"http://api.playsm.com/index.php?id=20&page=1&r=cartoonCategory%2FgetCartoonSetListByCategory&size=20&"

#define kXiaobian @"http://api.playsm.com/index.php?id=3&page=1&r=cartoonBillBoard%2FgetCartoonSetListByBillBoard&size=20&"



#define kMeizhou @"http://api.playsm.com/index.php?id=4&page=1&r=cartoonBillBoard%2FgetCartoonSetListByBillBoard&size=20&"
#define kShangjia @"http://api.playsm.com/index.php?id=21&page=1&r=cartoonCategory%2FgetCartoonSetListByCategory&size=20&"


#define kRenqi @"http://api.playsm.com/index.php?page=1&r=cartoonBillBoard%2FgetCartoonSetListByBillBoard&size=12&"
#define kDianji @"http://api.playsm.com/index.php?id=1&page=1&r=cartoonBillBoard%2FgetCartoonSetListByBillBoard&size=12&"
#define kAnli @"http://api.playsm.com/index.php?id=3&page=1&r=cartoonBillBoard%2FgetCartoonSetListByBillBoard&size=12&"
#define kShoucang @"http://api.playsm.com/index.php?id=4&page=1&r=cartoonBillBoard%2FgetCartoonSetListByBillBoard&size=12&"
#define kkkk @"http://api.playsm.com/index.php?id=12&page=1&r=cartoonBillBoard%2FgetCartoonSetListByBillBoard&size=12&"

#define kLieiBie @"http://api.playsm.com/index.php?r=cartoonCategory%2FgetCartoonSetListByCategory&size=12&"

#define kPic @"http://api.playsm.com/index.php?lastCount=240&page=1&r=prettyImages%2Flist&"
//searchLabel=%E5%8F%A4%E9%A3%8E&

#endif /* HWDefine_h */
