//
//  STShopAdlistModel.h
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STShopAdlistModel : NSObject

@property (nonatomic,copy) NSString *linkUrl;

@property (nonatomic,copy) NSString *sortOrder;

@property (nonatomic,copy) NSString *imgUrl;


/*
 "linkUrl" : "https://h5.blackfish.cn/m/shop/bargain/bargainList?hideNavigation:1",
 "sortOrder" : 1,
 "imgUrl" : "https://fb.blackfish.cn/fb/t1/G1/M00/00/5E/CiAgxVsjiT-IWujxAAE-5zXIWQIAAF2tgE9pLYAAT7_190.png"
 */


@end
