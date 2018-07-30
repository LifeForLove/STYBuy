//
//  STShopRecomListModel.h
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STShopRecomListModel : NSObject

@property (nonatomic,copy) NSString *productId;

@property (nonatomic,copy) NSString *commentRate;

@property (nonatomic,copy) NSString *imgUrl;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *price;


/*
 "productId" : 1075216,
 "commentRate" : 100,
 "imgUrl" : "https://fb.blackfish.cn/fb/t1/G1/M00/00/50/CiAgxVsFDt2IaShMAAjLFRnabWsAAF2VQI7Rg8ACMst751.png",
 "title" : "let's diet 儿童冰袖 2件装 蓝色 均码",
 "price" : 59.00
 */


@end
