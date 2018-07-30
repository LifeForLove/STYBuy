//
//  GXNetTools.m
//  LANGril
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GXNetTools.h"
#import "NSArray+Log.h"


@interface GXNetTools ()

@end

@implementation GXNetTools
+(instancetype)sharedAFNetTool
{
    static GXNetTools *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [GXNetTools manager];
        obj.requestSerializer.timeoutInterval = 10.f;
        obj.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return obj;
}

- (void)sendRequsetWithMessage:(void (^)(NSObject *, NSMutableDictionary *))requestMessage progress:(void (^)(NSProgress *))progressBlock successBlock:(void (^)(id))successBlock errorBlock:(void (^)(NSError *))errorBlock
{
    if (requestMessage) {
        NSObject * message = [NSObject new];
        message.st_parameters = [NSMutableDictionary dictionary];
        requestMessage(message,message.st_parameters);
        switch (message.st_method) {
            case STRequestMethodGET:
                [self getInfoWithRequestMessage:message progress:progressBlock andFinish:successBlock andError:errorBlock];
                break;
                
            case STRequestMethodPOST:
                [self postWithRequestMessage:message progress:progressBlock andSuccessBlock:successBlock addErrorBlock:errorBlock];
                break;
                
            default:
                break;
        }
    }
}


-(void)getInfoWithRequestMessage:(NSObject *)requestMessage progress:(void (^)(NSProgress *progres))progressBlock andFinish:(void(^)(id obj))successBlock andError:(void (^) (NSError * error))errorBlock
{
    
    if (requestMessage.st_needHUD) {
        [ELLoadingView show];
    }
    NSString * geturl = [NSString stringWithFormat:@"%@%@",HTTPURL,requestMessage.st_requestURL];
    [self logParameter:requestMessage.st_parameters withURL:geturl];
    [self GET:geturl parameters:requestMessage.st_parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestMessage.st_needHUD) {
            [ELLoadingView dismiss];
        }
        
        if (responseObject) {
            if (responseObject) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSInteger code = [responseObject[@"code"] integerValue];
                    if (code == 406) {
                        NSLog(@"tokenError");
                    }
                    successBlock(responseObject);
                }else{
                    NSLog(@"数据错误 %@",responseObject);
                }
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestMessage.st_needHUD) {
            [ELLoadingView dismiss];
        }
        errorBlock(error);
        //打印error
        [self logError:error];
    }];
    
}



-(void)postWithRequestMessage:(NSObject *)requestMessage progress:(void (^)(NSProgress *progres))progressBlock andSuccessBlock:(void(^)(id obj))successBlock addErrorBlock:(void (^) (NSError * error))errorBlock
{
    if (requestMessage.st_needHUD) {
        [ELLoadingView show];
    }
    NSString * posturl = [NSString stringWithFormat:@"%@%@",HTTPURL,requestMessage.st_requestURL];
    [self logParameter:requestMessage.st_parameters withURL:posturl];
    
    [self POST:posturl parameters:requestMessage.st_parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestMessage.st_needHUD) {
            [ELLoadingView dismiss];
        }
        if (responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSInteger code = [responseObject[@"code"] integerValue];
                if (code == 406) {
                    NSLog(@"tokenError");
                }
                successBlock(responseObject);
            }else{
                NSLog(@"数据错误 %@",responseObject);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestMessage.st_needHUD) {
            [ELLoadingView dismiss];
        }
        errorBlock(error);
        //打印error
        [self logError:error];
    }];
}



- (void)logParameter:(NSDictionary *)dic withURL:(NSString *)url
{
#ifdef DEBUG
    NSLog(@"参数 %@\n url = %@",dic,url);
#else
    //do sth.
#endif
}


/**
 打印error
 
 @param error error
 */
- (void)logError:(NSError *)error
{
#ifdef DEBUG
    NSError * error1 = [error userInfo][@"NSUnderlyingError"];
    NSData * data = error1.userInfo[@"com.alamofire.serialization.response.error.data"];
    NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
#else
    //do sth.
#endif
}


@end
