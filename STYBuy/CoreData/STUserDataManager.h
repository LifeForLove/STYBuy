//
//  STUserDataManager.h
//  STYBuy
//
//  Created by 高欣 on 2018/5/14.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STUserManager [STUserDataManager sharedUserManager]
#define STCurrentUser STUserManager.currentUser


@class STUser;
@interface STUserDataManager : NSObject


/**
 单例
 */
+(instancetype)sharedUserManager;

/**
 改
 */
- (void)change:(void (^) (STUser * user))userBlock;

/**
 查
 */
- (STUser *)currentUser;

/**
 退出登录
 */
- (void)loginOut:(void(^)(void))success fail:(void(^)(void))fail;

@end
