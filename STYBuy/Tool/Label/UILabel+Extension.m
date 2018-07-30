//
//  UILabel+Extension.m
//  STYBuy
//
//  Created by 高欣 on 2018/6/27.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
+ (instancetype)labelWithColor:(UIColor *)color font:(UIFont *)font alignment:(NSTextAlignment)alignment title:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = color;
    label.font = font;
    label.textAlignment = alignment;
    return label;
}


@end
