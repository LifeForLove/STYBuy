//
//  FBIWarningView.m
//  LANGirl
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FBIWarningView.h"
#define Key_Width   130
#define Key_height  150

@interface FBIWarningView ()
@property (nonatomic, strong) UIView *blurView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *messageLab;
@end



@implementation FBIWarningView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.bounds = CGRectMake(0, 0,Key_Width , Key_height);
        self.center = [UIApplication sharedApplication].keyWindow.center;
        //中间视图添加毛玻璃效果
        
        UIView * blurView = [[UIView alloc]init];
        blurView.backgroundColor = [UIColor whiteColor];
        blurView.alpha = 0.9;
        [self addSubview:blurView];
        blurView.layer.cornerRadius = 5;
        blurView.layer.masksToBounds = YES;
        blurView.frame = self.bounds;
        
        //显示数据的标签
        _messageLab = [[UILabel alloc] init];
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.numberOfLines = 0;
        _messageLab.textColor = Main_Color;
        _messageLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_messageLab];
        [_messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blurView).offset(10);
            make.left.equalTo(blurView).offset(10);
            make.right.equalTo(blurView).offset(-10);
            make.height.mas_equalTo(40);
        }];
        
        //图片
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_message_t"]];
        _imageView.bounds = CGRectMake(0, 0, 80, 80);
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(blurView);
            make.bottom.equalTo(blurView).offset(-10);
            make.size.mas_equalTo(80);
        }];
        
        
    }
    return self;
}


//显示，警告视图，自定义设置一段时间后，移除
+ (void)showMessage:(NSString *)message removeAfterDelay:(NSTimeInterval)delayTime
{
    FBIWarningView *warMessage = [[FBIWarningView alloc] init];
    warMessage.messageLab.text = message;
    
    [[self topViewController].view addSubview:warMessage];
    [warMessage performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:delayTime];
}


//显示，警告视图，1秒之后会自动移除
+ (void)showMessage:(NSString *)message
{
    [self showMessage:message removeAfterDelay:1];
}

//显示，警告框，1秒之后，自动移除，并且有回调
+ (void)showMessage:(NSString *)message andFanished:(void (^)(void))fanish
{
    [self showMessage:message];
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        fanish();
    });
}

+ (UIViewController *)topViewController
{
    UIViewController * resultVC;
    resultVC = [self getTopViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self getTopViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)getTopViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getTopViewController:[(UINavigationController *)vc topViewController]];
    }else if ([vc isKindOfClass:[UITabBarController class]])
    {
        return [self getTopViewController:[(UITabBarController *)vc selectedViewController]];
    }else
    {
        return vc;
    }
}


@end
