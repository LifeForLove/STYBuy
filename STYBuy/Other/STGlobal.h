//
//  STGlobal.h
//  STYBuy
//
//  Created by 高欣 on 2018/5/13.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#ifndef STGlobal_h
#define STGlobal_h

//  通知中心
#define STNotificationCenter [NSNotificationCenter defaultCenter]
//  NSUserDefaults
#define STUserDefaults [NSUserDefaults standardUserDefaults]

// Appdelegate
#define STSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


/**
 *  屏幕尺寸
 */
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX     ([UIScreen mainScreen].bounds.size.width == 375.f && [UIScreen mainScreen].bounds.size.height == 812.f)
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_SIZE     [UIScreen mainScreen].bounds.size
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height


//适配
#define AUTO_WIDTH [UIScreen mainScreen].bounds.size.width/375.0f
#define AUTO_HEIGHT [UIScreen mainScreen].bounds.size.height/667.0f

//导航高度
#define SafeAreaNavHeight (kScreenHeight == 812.0 ? 88 : 64)
//导航高度
#define SafeAreaNavHeight (kScreenHeight == 812.0 ? 88 : 64)
#define SafeAreaStateHeight (kScreenHeight == 812.0 ? 44 : 20)
//UITabBar高度由49pt变成了83pt,增加了34
#define SafeAreaTabbarHeight (kScreenHeight == 812.0 ? 83 : 49)

//iPhone X底部高度
#define SafeAreaBarIncreaseHeight (kScreenHeight == 812.0 ? 34 : 0)


#endif /* STGlobal_h */
