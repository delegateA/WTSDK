//
//  WTNetworking.h
//  WTSDK
//  Created by 张威庭 on 15/3/29.
//  Copyright (c) 2015年 张威庭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


//===================== 网络相关 ======================/
#define NetWorkError  @"网络连接失败!"

#define     NETWORKERROR            @"网络连接不可用，请稍后重试"

#define     NETWORKSERVERERROR            @"服务器异常，请稍后重试"

//===================== 网络相关 end======================/


@interface WTNetworking : NSObject

+(void)get:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure;


+(void)post:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr success:(void (^)(id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure;


+(void)post:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr constructingBodyWithBlock:(void (^)(id  formData))constructingBodyWithBlock  success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure;


//+(void)WeChatLogin:(NSString *)code result:(void(^)(NSDictionary *GetDic))result failure:(void(^)())failure;

@end
