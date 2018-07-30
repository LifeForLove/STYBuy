//
//  UIButton+Extension.h
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font;

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font backgroundNormalColor:(UIColor *)bgNormalColor;

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font backgroundNormalColor:(UIColor *)bgNormalColor backgroundHighlightedColor:(UIColor *)bgHighColor;

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font backgroundNormalColor:(UIColor *)bgNormalColor backgroundDisableColor:(UIColor *)bgDisableColor;

/**
 创建button

 @param color 文字颜色
 @param font 字体大小
 @param bgNormalColor 背景颜色
 @param bgHighColor 背景高亮
 @param bgDisableColor 禁用颜色
 @return button
 */
+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font backgroundNormalColor:(UIColor *)bgNormalColor backgroundHighlightedColor:(UIColor *)bgHighColor backgroundDisableColor:(UIColor *)bgDisableColor;

@end
