//
//  STBaseNav.m
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STBaseNav.h"

@interface STBaseNav ()

@end

@implementation STBaseNav

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /**
         监听成功退出登录的通知
         */
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginAgainAction) name:STLoginOutSuccessNotification object:nil];
    }
    return self;
}


/**
 重新登陆
 */
- (void)loginAgainAction
{
    //退回到根视图
    [self popToRootViewControllerAnimated:NO];
    //当退出到一级界面 刷新界面数据
    [[NSNotificationCenter defaultCenter]postNotificationName:STRefreshHomeDataNotification object:nil];
}



@end
