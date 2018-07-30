//
//  STEmptyView.h
//  STYBuy
//
//  Created by 高欣 on 2018/6/28.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    STEmptyType_NoData = 0,    //没数据
    STEmptyType_NoNetWork = 1, //没网
    STEmptyType_TimedOut = 2,  //请求超时
    STEmptyType_ErrorDefault = 3, //失败原因太多了 随便给一个
}STEmptyType;


@interface STEmptyView : UIView

@property (nonatomic,assign) STEmptyType emptyType;

@end
