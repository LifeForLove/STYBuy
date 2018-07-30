//
//  STShopModel.m
//  STYBuy
//
//  Created by 高欣 on 2018/7/8.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STShopModel.h"
#import "STShopTJZQModel.h"
#import "STShopRecomModel.h"
#import "STShopSinglAdModel.h"
@implementation STShopModel

+ (void)requestWithRequestMessage:(void (^)(NSObject *, NSMutableDictionary *))requestMessage success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    NSString *paths = [[NSBundle mainBundle] pathForResource:@"shop.json" ofType:nil];
    // 2.将数据加载成NSData
    NSData *data = [NSData dataWithContentsOfFile:paths];
    // 3.将data转成数组
    NSDictionary * obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dict = obj[@"data"];
    
    [STShopModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"bannerList" : @"STShopHeadModel", //头部轮播
                 @"targetList":@"STShopClassifyModel",   //商品分类
                 @"adList":@"STShopAdlistModel",       //广告
                 @"subjectList":@"STShopTJZQModel"   //特价专区
                 };
    }];

    [STShopTJZQModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"productList":@"STProductListModel"
                 };
    }];

    STShopModel * model = [STShopModel mj_objectWithKeyValues:dict];

    [STShopRecomModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"productList":@"STShopRecomListModel"
                 };
    }];
    
    model.recommend = [STShopRecomModel mj_objectWithKeyValues:dict[@"recommend"]];
    model.singleAd = [STShopSinglAdModel mj_objectWithKeyValues:dict[@"singleAd"]];
    
    successBlock(model);
    
}

@end
