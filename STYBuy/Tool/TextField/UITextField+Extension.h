//
//  UITextField+Extension.h
//  STYBuy
//
//  Created by 高欣 on 2018/5/12.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
@property(nonatomic,assign)NSInteger maxCount;//可输入的字数

@property (nonatomic, assign) NSInteger moneyCount; //可输入金额


/**
 限制输入的最大金额
 */
@property (nonatomic, assign) NSInteger maxMoney;
@end
