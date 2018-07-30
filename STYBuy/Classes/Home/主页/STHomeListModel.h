//
//  STHomeListModel.h
//  STYBuy
//
//  Created by 高欣 on 2018/6/27.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STHomeListModel : NSObject<STModelProtocol>
@property (nonatomic, copy) NSString *cotext;
@property (nonatomic, copy) NSString *cotime;
@property (nonatomic, copy) NSString *headpic;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *reply;
@property (nonatomic, copy) NSString *lnum;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, copy) NSString *rnum;
@property (nonatomic, strong) NSArray *imgs;

@end
