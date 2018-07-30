//
//  ELLoadingView.m
//  RACMVVMDemo
//
//  Created by getElementByYou on 2018/4/30.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "ELLoadingView.h"
#import "ELDotView.h"
@interface ELLoadingView ()

@property (nonatomic, readonly) UIView *frontWindow;

@property (nonatomic, strong) UIControl *controlView;

@end


@implementation ELLoadingView

+ (ELLoadingView *)shareView
{
    static ELLoadingView * obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[ELLoadingView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return obj;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (void)setBackgroundColor:(UIColor *)color
{
    [self shareView].backgroundColor = color;
}

+ (void)show
{
    [[self shareView]show:nil];
}

- (void)show:(void(^)(void))complate
{
    [self createView];
    __weak ELLoadingView *weakSelf = self;
    [UIView animateWithDuration:0.01 animations:^{
        __strong ELLoadingView *strongSelf = weakSelf;
        strongSelf.alpha = strongSelf.controlView.alpha = 1;
        [ELDotView dotShowInView:self];
    } completion:^(BOOL finished) {
        if (complate) {
            complate();
        }
    }];
}

+ (void)dismiss
{
    [[self shareView] dissmiss:0.2 completion:nil];
}

- (void)dissmiss:(NSTimeInterval)delay completion:(void (^)(void))completion
{
    __weak ELLoadingView *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [UIView animateWithDuration:delay animations:^{
            __strong ELLoadingView *strongSelf = weakSelf;
            strongSelf.alpha = strongSelf.controlView.alpha = 0;
        } completion:^(BOOL finished) {
            __strong ELLoadingView *strongSelf = weakSelf;
            if (completion) {
                completion();
            }
            [ELDotView dotDismiss];
            [strongSelf.controlView removeFromSuperview];
            [strongSelf removeFromSuperview];
        }];
    }];
}



- (void)createView
{
    if (!self.controlView.superview) {
        [self.frontWindow addSubview:self.controlView];
    }
    if (!self.superview) {    
        [self.controlView addSubview:self];
    }
}

/*
 背景点击事件
 */
- (void)controlViewDidReceiveTouchEvent:(id)sender forEvent:(UIEvent*)event {
    
}

- (UIControl*)controlView {
    if(!_controlView) {
        _controlView = [UIControl new];
        _controlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _controlView.backgroundColor = [UIColor clearColor];
        _controlView.userInteractionEnabled = YES;
        [_controlView addTarget:self action:@selector(controlViewDidReceiveTouchEvent:forEvent:) forControlEvents:UIControlEventTouchDown];
    }
    _controlView.frame = [UIScreen mainScreen].bounds;

    return _controlView;
}

- (UIWindow *)frontWindow {
    return [UIApplication sharedApplication].keyWindow;
}

@end
