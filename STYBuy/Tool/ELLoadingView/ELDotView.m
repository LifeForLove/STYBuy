//
//  ELDotView.m
//  RACMVVMDemo
//
//  Created by getElementByYou on 2018/5/1.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "ELDotView.h"


typedef NS_ENUM(NSInteger,DotDitection)
{
    DotDitectionLeft = -1,
    DotDitectionRight = 1,
};
@interface ELDot : UIView
//移动方向 就两种 左、右
@property (nonatomic,assign) DotDitection direction;
@end
@implementation ELDot
@end




@interface ELDotView ()

@property (nonatomic,strong) NSMutableArray *dots;

@property (nonatomic,strong) CADisplayLink *link;

@property (nonatomic,strong) UIView *dotContainer;


@end

@implementation ELDotView


+ (ELDotView *)shareView
{
    static ELDotView * obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[ELDotView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return obj;
}


//豆的宽度
-(CGFloat)dotWidth
{
    CGFloat margin = _dotContainer.bounds.size.width/5.0f;
    CGFloat dotWidth = (_dotContainer.bounds.size.width - margin)/2.0f;
    return  dotWidth;
}

-(CGFloat)speed
{
    return  2.0f;
}


//开始动画
-(void)start
{
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

//停止动画
-(void)stop
{
    [self.link invalidate];
    self.link = nil;
}

//刷新UI
-(void)reloadView
{
    ELDot *dot1 = self.dots.firstObject;
    
    ELDot *dot2 = self.dots.lastObject;
    
    //改变移动方向、约束移动范围
    //移动到右边距时
    if (dot1.center.x >= _dotContainer.bounds.size.width - [self dotWidth]/2.0f) {
        CGPoint center = dot1.center;
        center.x = _dotContainer.bounds.size.width - [self dotWidth]/2.0f;
        dot1.center = center;
        dot1.direction = DotDitectionLeft;
        dot2.direction = DotDitectionRight;
        [_dotContainer bringSubviewToFront:dot1];
    }
    //移动到左边距时
    if (dot1.center.x <= [self dotWidth]/2.0f) {
        dot1.center = CGPointMake([self dotWidth]/2.0f, dot2.center.y);
        dot1.direction = DotDitectionRight;
        dot2.direction = DotDitectionLeft;
        [self.dotContainer sendSubviewToBack:dot1];
    }
    
    //更新第一个豆的位置
    CGPoint center1 = dot1.center;
    center1.x += dot1.direction * [self speed];
    dot1.center = center1;
    //显示放大效果
    [self showAnimationsOfDot:dot1];
    
    //根据第一个豆的位置确定第二个豆的位置
    CGFloat apart = dot1.center.x - _dotContainer.bounds.size.width/2.0f;
    CGPoint center2 = dot2.center;
    center2.x = _dotContainer.bounds.size.width/2.0f - apart;
    dot2.center = center2;
    [self showAnimationsOfDot:dot2];
}

//初始化两个豆
-(void)buildUI
{
    //一个豆放左 一个豆放右
    NSArray *dotBackGroundColors = @[[self R:251 G:74 B:74 A:1],[self R:245 G:229 B:216 A:1]];
    for (NSInteger i = 0; i<dotBackGroundColors.count; i++) {
        CGFloat dotX = i==0 ? 0 : _dotContainer.bounds.size.width - [self dotWidth];
        //初始化开始运动的方向 左边的方向是向右 右边的方向是向左
        DotDitection direction = i==0 ? DotDitectionRight : DotDitectionLeft;
        ELDot *dot = [[ELDot alloc] initWithFrame:CGRectMake(dotX, 0, [self dotWidth],[self dotWidth])];
        dot.center = CGPointMake(dot.center.x, _dotContainer.bounds.size.height/2.0f);
        dot.layer.cornerRadius = dot.bounds.size.width/2.0f;
        dot.backgroundColor = dotBackGroundColors[i];
        dot.direction = direction;
        [self.dotContainer addSubview:dot];
        [self.dots addObject:dot];
    }
}



//显示放大、缩小动画
-(void)showAnimationsOfDot:(ELDot*)dot
{
    CGFloat apart = dot.center.x - self.dotContainer.bounds.size.width/2.0f;
    //最大距离
    CGFloat maxAppart = (self.dotContainer.bounds.size.width - [self dotWidth])/2.0f;
    //移动距离和最大距离的比例
    CGFloat appartScale = apart/maxAppart;
    //获取比例对应余弦曲线的Y值
    CGFloat transfomscale = cos(appartScale * M_PI/2.0);
    //向右移动则 中间变大 两边变小
    if (dot.direction == DotDitectionLeft) {
        dot.transform = CGAffineTransformMakeScale(1 + transfomscale/4.0f, 1 + transfomscale/4.0f);
        //向左移动则 中间变小 两边变大
    }else if (dot.direction == DotDitectionRight){
        dot.transform = CGAffineTransformMakeScale(1 - transfomscale/4.0f,1 - transfomscale/4.0f);
    }
}

-(UIColor*)R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a
{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

+(ELDotView *)getLoadingInView:(UIView *)view {
    
    ELDotView *loading = nil;
    for (ELDotView *subview in view.subviews) {
        if ([subview isKindOfClass:[ELDotView class]]) {
            loading = subview;
        }
    }
    return loading;
}

+ (void)dotShowInView:(UIView*)view
{
    if (![self shareView].superview) {
        [view addSubview:[self shareView]];
    }

    if (![self shareView].dotContainer.superview) {
        [[self shareView] addSubview:[self shareView].dotContainer];
    }
    [[self shareView] buildUI];
    [[self shareView] start];
}

+ (void)dotDismiss
{
    [[self shareView] stop];
    [[self shareView].dotContainer removeFromSuperview];
    [[self shareView] removeFromSuperview];
    for (UIView * view in [self shareView].dots) {
        [view removeFromSuperview];
    }
    [[self shareView].dots removeAllObjects];
}

- (CADisplayLink *)link
{
    if (_link == nil) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(reloadView)];
    }
    return _link;
}

- (NSMutableArray *)dots
{
    if (_dots == nil) {
        _dots = [NSMutableArray array];
    }
    return _dots;
}

- (UIView *)dotContainer
{
    if (_dotContainer == nil) {
        _dotContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
        _dotContainer.center = self.center;
    }
    return _dotContainer;
}


@end
