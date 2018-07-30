//
//  UILabel+Extension.m
//  MartialMaster
//
//  Created by apple on 2017/9/22.
//  Copyright © 2017年 getElementByYou. All rights reserved.
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
