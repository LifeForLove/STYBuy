//
//  STModelProtocol.h
//  STYBuy
//
//  Created by 高欣 on 2018/6/28.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STModelProtocol <NSObject>

/**
 *  加载数据
 */
+ (void)requestWithRequestMessage:(void (^) (NSObject *message,NSMutableDictionary * dict))requestMessage success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock;

@end
