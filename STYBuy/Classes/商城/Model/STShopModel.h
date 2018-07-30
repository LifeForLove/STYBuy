//
//  STShopModel.h
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class STShopRecomModel;
@class STShopSinglAdModel;
@interface STShopModel : NSObject<STModelProtocol>

@property (nonatomic,strong) NSArray *identiList;

/**
 首页轮播
 */
@property (nonatomic,strong) NSArray *bannerList;

/**
 商品分类
 */
@property (nonatomic,strong) NSArray *targetList;

/**
 单品广告
 */
@property (nonatomic,strong) STShopSinglAdModel *singleAd;

/**
 广告
 */
@property (nonatomic,strong) NSArray *adList;

/**
 特价专区
 */
@property (nonatomic,strong) NSArray *subjectList;

/**
 推荐列表
 */
@property (nonatomic,strong) STShopRecomModel *recommend;

@end
