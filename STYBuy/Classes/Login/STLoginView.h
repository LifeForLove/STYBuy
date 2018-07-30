//
//  STLoginView.h
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STBaseNav.h"

typedef void(^resultBlock)(NSInteger code);

@interface STLoginView : STBaseNav

@property (nonatomic,copy) resultBlock result;

/**
 展示登录界面

 @param result 回调登录结果
 */
+ (void)show:(resultBlock)result;

@end
