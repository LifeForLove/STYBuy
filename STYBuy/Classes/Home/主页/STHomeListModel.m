//
//  STHomeListModel.m
//  STYBuy
//
//  Created by 高欣 on 2018/6/27.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "STHomeListModel.h"

@implementation STHomeListModel

+ (void)requestWithRequestMessage:(void (^)(NSObject *, NSMutableDictionary *))requestMessage success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock
{
    [[GXNetTools sharedAFNetTool] sendRequsetWithMessage:requestMessage progress:nil successBlock:^(id obj) {
        NSArray * modelList = @[];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary * data = obj[@"data"];
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSArray * main = data[@"main"];
                if ([main isKindOfClass:[NSArray class]]) {
                    modelList = [STHomeListModel mj_objectArrayWithKeyValuesArray:main];
                }
            }
        }
        successBlock(modelList);
    } errorBlock:^(NSError *error) {
        failureBlock(error);
    }];
}


@end
