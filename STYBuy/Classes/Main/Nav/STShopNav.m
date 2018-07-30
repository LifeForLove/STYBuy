//
//  STShopNav.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STShopNav.h"
#import "STShopVC.h"
@interface STShopNav ()

@end

@implementation STShopNav

- (instancetype)init
{
    self = [super init];
    if (self) {
        STShopVC * vc = [[STShopVC alloc]init];
        [self pushViewController:vc animated:NO];
    }
    return self;
}

@end
