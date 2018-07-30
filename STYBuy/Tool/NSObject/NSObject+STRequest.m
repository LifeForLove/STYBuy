//
//  NSObject+STRequest.m
//  STYBuy
//
//  Created by 高欣 on 2018/6/27.
//  Copyright © 2018年 getElementByYou. All rights reserved.
//

#import "NSObject+STRequest.h"
#import <objc/runtime.h>

@implementation NSObject (STRequest)

- (NSMutableDictionary *)st_parameters
{
    return objc_getAssociatedObject(self, @selector(st_parameters));
}
- (void)setSt_parameters:(NSMutableDictionary *)st_parameters
{
    objc_setAssociatedObject(self, @selector(st_parameters), st_parameters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSString *)st_requestURL
{
    return objc_getAssociatedObject(self, @selector(st_requestURL));
}
- (void)setSt_requestURL:(NSString *)st_requestURL
{
    objc_setAssociatedObject(self, @selector(st_requestURL), st_requestURL, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



- (STRequestMethod)st_method
{
    return [objc_getAssociatedObject(self, @selector(st_method)) integerValue];
}

- (void)setSt_method:(STRequestMethod)st_method
{
    objc_setAssociatedObject(self, @selector(st_method), @(st_method), OBJC_ASSOCIATION_ASSIGN);
}



- (BOOL)st_needHUD
{
    return [objc_getAssociatedObject(self, @selector(st_needHUD)) boolValue];
}
- (void)setSt_needHUD:(BOOL)st_needHUD
{
    objc_setAssociatedObject(self, @selector(st_needHUD), @(st_needHUD), OBJC_ASSOCIATION_ASSIGN);
}


@end
