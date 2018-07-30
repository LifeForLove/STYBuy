//
//  UIButton+Extension.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font
{
    return [self buttonWithTextColor:color font:font backgroundNormalColor:nil];
}

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font backgroundNormalColor:(UIColor *)bgNormalColor
{
    return [self buttonWithTextColor:color font:font backgroundNormalColor:bgNormalColor backgroundHighlightedColor:nil];
}

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font backgroundNormalColor:(UIColor *)bgNormalColor backgroundHighlightedColor:(UIColor *)bgHighColor
{
    return [self buttonWithTextColor:color font:font backgroundNormalColor:bgNormalColor backgroundHighlightedColor:bgHighColor backgroundDisableColor:nil];
}

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font backgroundNormalColor:(UIColor *)bgNormalColor backgroundDisableColor:(UIColor *)bgDisableColor
{
    return [self buttonWithTextColor:color font:font backgroundNormalColor:bgNormalColor backgroundHighlightedColor:nil backgroundDisableColor:bgDisableColor];
}

+ (instancetype)buttonWithTextColor:(UIColor *)color font:(UIFont *)font backgroundNormalColor:(UIColor *)bgNormalColor backgroundHighlightedColor:(UIColor *)bgHighColor backgroundDisableColor:(UIColor *)bgDisableColor
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (color) [btn setTitleColor:color forState:UIControlStateNormal];
    if (font) btn.titleLabel.font = font;
    if (bgNormalColor)[btn setBackgroundImage:[UIImage createImageWithColor:bgNormalColor] forState:UIControlStateNormal];
    if (bgHighColor)[btn setBackgroundImage:[UIImage createImageWithColor:bgHighColor] forState:UIControlStateHighlighted];
    if (bgDisableColor)[btn setBackgroundImage:[UIImage createImageWithColor:bgDisableColor] forState:UIControlStateDisabled];
    return btn;
}






@end
