//
//  UIImageView+Extension.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/6.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (void)iconImg_setImageWithString:(NSString *)urlstr
{
    [self sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"icon_bg"] completed:nil];
}




@end
