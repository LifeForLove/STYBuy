//
//  SHRightWrongView.m
//  YesNo
//
//  Created by getElementByYou on 2016/12/24.
//  Copyright © 2016年 getElementByYou. All rights reserved.
//

#import "SHRightWrongView.h"

/*************** 屏幕的宽高 ***************/
#define SHRightWrong_width   [UIScreen mainScreen].bounds.size.width
#define SHRightWrong_heigh   [UIScreen mainScreen].bounds.size.height

/*************** 模糊层的宽度 ***************/
#define SHBlur_Width        130
#define SHBlur_Height       150


/*************** 圆的宽度 ***************/
#define SHCirCel_Width      80

/*************** 绘制的线的颜色、宽度 ***************/
#define SHStroke_Color      Main_Color
#define SHLine_Width        2





@interface SHRightWrongView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIBezierPath *bezierpath;
@property (nonatomic,strong) UIView *cirecleView;


/*************** 类型 ***************/
@property (nonatomic,assign) SHRightWrongViewType type;


@end

@implementation SHRightWrongView



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        UIView *backgroungView = [[UIView alloc] initWithFrame:self.bounds];
        backgroungView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        backgroungView.opaque = NO;
        backgroungView.alpha = 0.3;
        [self addSubview:backgroungView];

        /*************** 模糊层 ***************/
        UIView * blurView = [[UIView alloc]init];
        blurView.backgroundColor = [UIColor whiteColor];
        blurView.alpha = 0.9;
        [self addSubview:blurView];
        blurView.layer.cornerRadius = 5;
        blurView.layer.masksToBounds = YES;
        blurView.frame = CGRectMake(0, 0, SHBlur_Width , SHBlur_Height);
        blurView.center = self.center;
        
        /*************** 圆 ***************/
        self.cirecleView    =   [[UIView alloc] initWithFrame:CGRectMake((SHBlur_Width - SHCirCel_Width)/2 , 60 , SHCirCel_Width , SHCirCel_Width)];
        self.cirecleView.backgroundColor    =   [UIColor clearColor];
        [blurView addSubview:self.cirecleView];
        
        /*************** 画圆 ***************/
        [self drawCircle];
        
        /*************** 标题 ***************/
        UILabel *label = [[UILabel alloc] init];
        self.titleLabel = label;
        label.textAlignment =   NSTextAlignmentCenter;
        label.textColor =   Main_Color;
        label.text  =   @"保存成功";
        [blurView addSubview:label];
        label.frame = CGRectMake(10, 10, 110, 40);
    }
    return self;
}

/*************** 添加圆 ***************/
- (void)drawCircle
{
    /*************** 设置路径 ***************/
    CGPoint arcCenter  = CGPointMake(SHCirCel_Width / 2, SHCirCel_Width / 2);
    CGFloat arcRadius  = SHCirCel_Width / 2 - 5;
    CGFloat startAngle = -M_PI / 2 ;
    CGFloat stopAngle  = M_PI / 2 * 3;
    self.bezierpath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:arcRadius startAngle:startAngle endAngle:stopAngle clockwise:YES];
    self.bezierpath.lineCapStyle  = kCGLineCapRound;
    self.bezierpath.lineJoinStyle = kCGLineCapRound;
    
}


//对号
/*************** 对号的点 ***************/
- (void)addRightView
{
    [self.bezierpath moveToPoint:CGPointMake( SHCirCel_Width  / 2 -13 ,SHCirCel_Width /2 )];
    [self.bezierpath addLineToPoint:CGPointMake(SHCirCel_Width / 2-3, SHCirCel_Width / 2 + 10)];
    [self.bezierpath addLineToPoint:CGPointMake(SHCirCel_Width / 2 + 10, SHCirCel_Width / 2 - 10)];
}
//叉号
- (void)addWrongView
{
    /*************** 线1 ***************/
    [self.bezierpath moveToPoint:CGPointMake( 30 , 30 )];
    [self.bezierpath addLineToPoint:CGPointMake(50,50)];
    
    /*************** 线2 ***************/
    [self.bezierpath moveToPoint:CGPointMake(50,30)];
    [self.bezierpath addLineToPoint:CGPointMake(30,50)];
}

//感叹号
- (void)addGanTanView
{
    [self.bezierpath moveToPoint:CGPointMake( SHCirCel_Width  / 2 , SHCirCel_Width /4 )];
    [self.bezierpath addLineToPoint:CGPointMake(SHCirCel_Width  / 2, SHCirCel_Width / 4* 2.7)];
    
    [self.bezierpath moveToPoint:CGPointMake(SHCirCel_Width /2, SHCirCel_Width / 4 * 2.8)];
    [self.bezierpath addLineToPoint:CGPointMake(SHCirCel_Width / 2, SHCirCel_Width / 4 * 3)];
    
    
    
}


/*************** 开始动画 ***************/
- (void)beginAnimation
{
    /*************** 设置layer ***************/
    CAShapeLayer *shapeLayer    = [CAShapeLayer layer];
    shapeLayer.fillColor        = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor      = SHStroke_Color.CGColor;
    shapeLayer.lineWidth        = SHLine_Width;
    shapeLayer.path             = self.bezierpath.CGPath;
    
    /*************** 开始动画 ***************/
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue     = @0;
    animation.toValue       = @1;
    animation.duration      = 1;
    [shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.cirecleView.layer addSublayer:shapeLayer];
}


/*************** 显示：1.5s后自动取消 ***************/
+ (void)showType:(SHRightWrongViewType)type andTitle:(NSString *)title Fanish:(void (^)(void))fanish
{
    [self showType:type andTitle:title delay:1.5 Fanish:fanish];
}

/*************** 显示： ***************/
+ (void)showType:(SHRightWrongViewType)type andTitle:(NSString *)title delay:(CGFloat)delay Fanish:(void (^)(void))fanish
{
    SHRightWrongView *view = [[SHRightWrongView alloc] init];
    if (type == SHRightWrongViewTypeRight) {
        [view addRightView];
    }
    if (type == SHRightWrongViewTypeWrong) {
        [view addWrongView];
    }
    if (type == SHRightWrongViewTypeGanTan) {
        [view addGanTanView];
    }
    view.titleLabel.text    =   title;
    [view beginAnimation];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    
    /*************** 延迟：自动删除 ***************/
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
        if (fanish) {
            fanish();
        }
    });
    
}





@end

























