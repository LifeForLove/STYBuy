//
//  STMineNav.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STMineNav.h"
#import "STMineVC.h"
@interface STMineNav ()

@end

@implementation STMineNav

- (instancetype)init
{
    self = [super init];
    if (self) {
        STMineVC * vc = [[STMineVC alloc]init];
        [self pushViewController:vc animated:NO];
    }
    return self;
}

@end
