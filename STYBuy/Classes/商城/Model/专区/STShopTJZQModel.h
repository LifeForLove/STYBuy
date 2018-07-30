//
//  STShopTJZQModel.h
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STProductListModel.h"
@interface STShopTJZQModel : NSObject

@property (nonatomic,copy) NSString *imgUrl;

@property (nonatomic,copy) NSString *linkUrl;

@property (nonatomic,copy) NSString *activityId;

@property (nonatomic,copy) NSString *activityName;

@property (nonatomic,strong) NSArray<STProductListModel *> *productList;


/*
 {
 "imgUrl" : "https://fb.blackfish.cn/fb/t1/G1/M00/00/3D/CiAg21rvxWOIVwlgAAHYg8LKIuUAAF1kgNT8ScAAdib706.jpg",
 "linkUrl" : "https://h5.blackfish.cn/m/promotion/3/89",
 "activityId" : 89,
 "activityName" : "9.9元特价专区",
 "template" : 3,
 "productList" : [
 {
 "productId" : 1100943,
 "imgUrl" : "https://fb.blackfish.cn/fb/t1/G1/M00/00/62/CiAg21sspbqIB8hKAAKg2uyoDtQAAF20QH1OyQAAqDy725.jpg",
 "title" : "迷你手机小风扇静音大风力苹果安卓手机电风扇 蓝色-苹果专用",
 "price" : 9.90
 }
 ,
 {
 "productId" : 1074970,
 "imgUrl" : "https://fb.blackfish.cn/fb/t1/G1/M00/00/50/CiAgxVr-SzCIPRcOAAGuWRH5CEMAAF2PAMEVi4AAa5x492.jpg",
 "title" : "贝丽丝香水沐浴露29元包邮 直降50元 限量5000件 法国大师调香 卢浮魅影600ml",
 "price" : 29.90
 },
 {
 "productId" : 1100759,
 "imgUrl" : "https://fb.blackfish.cn/fb/t1/G1/M00/00/60/CiAgxVsrt3KIZZMpAALul6AWjyYAAF2zgHGYyIAAu6v306.jpg",
 "title" : "樵纪 珍珠棉U型枕头",
 "price" : 13.00
 }
 ]
 }
 
 */


@end
