//
//  NSObject+STRequest.h
//  STYBuy
//
//  Created by 高欣 on 2018/6/27.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    /** GET */
    STRequestMethodGET,
    /** POST */
    STRequestMethodPOST,
    
} STRequestMethod;


@interface NSObject (STRequest)

/**
 链接
 */
@property (nonatomic,copy) NSString *st_requestURL;


/**
 参数
 */
@property (nonatomic,strong) NSMutableDictionary *st_parameters;


/**
 method
 */
@property (nonatomic, assign) STRequestMethod st_method;


/**
 是否需要显示加载弹窗
 */
@property (nonatomic,assign) BOOL st_needHUD;


@end
