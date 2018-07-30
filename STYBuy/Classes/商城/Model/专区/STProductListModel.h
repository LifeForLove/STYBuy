//
//  STProductListModel.h
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STProductListModel : NSObject

@property (nonatomic,copy) NSString *productId;

@property (nonatomic,copy) NSString *imgUrl;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *price;

/*
 "productId" : 1100943,
 "imgUrl" : "https://fb.blackfish.cn/fb/t1/G1/M00/00/62/CiAg21sspbqIB8hKAAKg2uyoDtQAAF20QH1OyQAAqDy725.jpg",
 "title" : "迷你手机小风扇静音大风力苹果安卓手机电风扇 蓝色-苹果专用",
 "price" : 9.90
 
 */

@end
