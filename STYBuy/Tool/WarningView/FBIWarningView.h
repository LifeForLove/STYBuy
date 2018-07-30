//
//  FBIWarningView.h
//  LANGirl
//
//  Created by apple on 2017/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBIWarningView : UIView

/**
 显示警告视图，默认1秒之后，会自动移除。如果想要自己设置时间，请使用下面的方法
 
 @param message 显示的内容。
 */
+ (void)showMessage:(NSString *)message;


/**
 显示警告视图并且短暂延迟之后移除
 
 @param message 显示的消息
 @param delayTime 延迟的时间
 */
+ (void)showMessage:(NSString *)message removeAfterDelay:(NSTimeInterval)delayTime;



/**
 显示警告框1秒后，自动移除
 
 @param message 显示的内容
 @param fanish 完成后的操作
 */
+ (void)showMessage:(NSString *)message andFanished:(void(^)(void))fanish;



@end
