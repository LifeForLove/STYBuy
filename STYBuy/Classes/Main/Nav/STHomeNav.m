//
//  STHomeNav.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STHomeNav.h"
#import "STHomeVC.h"
@interface STHomeNav ()

@end

@implementation STHomeNav

- (instancetype)init
{
    self = [super init];
    if (self) {
        STHomeVC * vc = [[STHomeVC alloc]init];
        [self pushViewController:vc animated:NO];
    }
    return self;
}

@end
