//
//  STNotification.h
//  STYBuy
//
//  Created by 高欣 on 2018/5/13.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#ifndef STNotification_h
#define STNotification_h

// 切换根控制器的通知
static NSString * const STSwitchRootViewControllerNotification = @"STSwitchRootViewControllerNotification";
// 切换根控制器的通知 UserInfo key
static NSString * const STSwitchRootViewControllerUserInfoKey = @"STSwitchRootViewControllerUserInfoKey";
// 获取系统版本号的key
static NSString * const STUserDefaultVersionKey = @"STUserDefaultVersionKey";
//刷新一级界面的通知
static NSString *const STRefreshHomeDataNotification = @"STRefreshHomeDataNotification";
//成功退出登录的通知
static NSString *const STLoginOutSuccessNotification = @"STLoginOutSuccessNotification";



#endif /* STNotification_h */
