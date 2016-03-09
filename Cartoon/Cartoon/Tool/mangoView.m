//
//  mangoView.m
//  UIGestureRecoginer
//
//  Created by scjy on 15/11/25.
//  Copyright (c) 2015年 苹果IOS. All rights reserved.
//

#import "mangoView.h"
@interface mangoView()


@end
@implementation mangoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadingCustumView];
    }
    return self;
}
-(void)loadingCustumView{
    self.backgroundColor= [UIColor cyanColor];
//旋转手势
    
    self.rotationImageView = [[UIImageView alloc] initWithFrame:self.frame];
//    self.rotationImageView.image = [UIImage imageNamed:@"雪景.jpg"];
    //打开imageView的用户交互
    //用户交互是指响应触摸事件
    self.rotationImageView.userInteractionEnabled = YES;
    [self addSubview:self.rotationImageView];
//    
//    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
//    [self.rotationImageView addGestureRecognizer:rotation];

    
//轻拍手势
    //初始化 创建一个轻拍手势，并设置target action
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    tap.numberOfTapsRequired = 1;
//    //手指个数
//    tap.numberOfTouchesRequired = 2;
//    //将手势添加到视图上
//    [self  addGestureRecognizer:tap];
    
//长按手势
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//    //长按时间
//    longPress.minimumPressDuration = 3.0;
//    //手指个数
//    longPress.numberOfTapsRequired = 1;
//    [self addGestureRecognizer:longPress];
    
 
//捏合手势
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
//    [self addGestureRecognizer:pinch];

    
//平移手势
  
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
 
//清扫手势
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
//    //设置方向，只能设置水平方向或者垂直方向
//    swipe.direction = UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
    //添加到视图上
    
//    [self.rotationImageView addGestureRecognizer:swipe];
//    UISwipeGestureRecognizer *swipedown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction1:)];
//    //设置方向
//    swipedown.direction = UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
//    //添加到视图上
//    
//    [self.rotationImageView addGestureRecognizer:swipedown];

    
//从屏幕边缘清扫
//    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanAction:)];
//    //只能设置一个方向的边缘清扫
//    screenEdgePan.edges =  UIRectEdgeRight;
//    [self.rotationImageView addGestureRecognizer:screenEdgePan];
    
    
    
    
}
-(void)screenEdgePanAction:(UIScreenEdgePanGestureRecognizer *)screenEdgePan{

    NSLog(@"O_O");

}
-(void)swipeAction:(UISwipeGestureRecognizer *)swipe{
    
//    NSLog(@"T_T ||||");
}
-(void)swipeAction1:(UISwipeGestureRecognizer *)swipe{
//    NSLog(@"T_T ----");
}

-(void)panAction:(UIPanGestureRecognizer *)pan{

    CGPoint offset = [pan translationInView:self.rotationImageView];
#pragma mark ----形变
    self.rotationImageView.transform =CGAffineTransformTranslate(self.rotationImageView.transform, offset.x, offset.y);
    //每次都相对于0点平移
    [pan setTranslation:CGPointZero inView:self.rotationImageView];
}
-(void)pinchAction:(UIPinchGestureRecognizer *)pinch{

    //捏合手势有一个属性scale就是捏合的比例
   // CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
    //第一个参数是上一次形变的位置
//    
//    self.rotationImageView.transform = CGAffineTransformScale(self.rotationImageView.transform, pinch.scale, pinch.scale);
//    //把缩放比例重制成1.0，每次放大或缩小都是基于1.0
//    pinch.scale = 1;


}
-(void)rotation:(UIRotationGestureRecognizer *)rotation{

    //CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)第一个参数是视图原来的形变状态
    //第二个参数是旋转手势旋转的弧度
//    self.rotationImageView.transform = CGAffineTransformRotate(self.rotationImageView.transform, rotation.rotation);
//    NSLog(@"%f",rotation.rotation);
//    
//    //重制旋转角度，如果不重置那么每次都是基于上次的旋转角度进行旋转,假如上次旋转到45度的位置，下个位置是46度的位置，如果不重置为0，那么第二一次形变就变成了45+46 = 91度位置，跨度范围较大，导致图片旋转越来越快
//    rotation.rotation = 0;
}
-(void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    //长安手势默认执行两次，第一次是长按手势识别的时候，然后手指离开的时候也会触发一次
//    if (longPress.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"= 3 =");
//
//    }else if(longPress.state == UIGestureRecognizerStateEnded){
//        NSLog(@"|||= =");
//    }
}
-(void)tapAction{

    NSLog(@"O(* _ *)O");

}
@end
