//
//  GXNetTools.h
//  LANGril
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GXNetTools : AFHTTPSessionManager
+(instancetype)sharedAFNetTool;

//- (void)sendRequsetWithMessage:(NSObject *)requestMessage progress:(void (^)(NSProgress *progres))progressBlock  successBlock:(void(^)(id obj))successBlock errorBlock:(void (^) (NSError * error))errorBlock;

- (void)sendRequsetWithMessage:(void (^) (NSObject *message,NSMutableDictionary * dict))requestMessage progress:(void (^)(NSProgress *progres))progressBlock  successBlock:(void(^)(id obj))successBlock errorBlock:(void (^) (NSError * error))errorBlock;

@end
