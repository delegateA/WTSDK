//
//  WTNetworking.m
//
//  Created by 张威庭 on 15/3/29.
//  Copyright (c) 2015年 张威庭. All rights reserved.
//

#import "WTNetworking.h"

@implementation WTNetworking
//2.0
//+(void)get:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure{
//    //1.创建请求管理者
//    if (!mgr) {
//        mgr=[AFHTTPRequestOperationManager manager];
//        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
//        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//        mgr.requestSerializer.timeoutInterval = 30;
//    }
//    //2.发送请求
//    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if(success){
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//
//
//}

//update3.0
+ (void)get:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPSessionManager *)mgr success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    //1.创建请求管理者
    if (!mgr) {
        mgr = [AFHTTPSessionManager manager];
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 30;
    }
    //2.发送请求
    //    [mgr GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    //        if(success){
    //            success(responseObject);
    //        }
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        if (failure) {
    //            failure(error);
    //        }
    //    }];

    [mgr GET:url parameters:params progress:^(NSProgress *_Nonnull downloadProgress) {

    }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
}

//2.0
//+(void)post:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr success:(void (^)(id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure{
//
//    //1.创建请求管理者
//    if (!mgr) {
//        mgr=[AFHTTPRequestOperationManager manager];
//        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
//        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//        mgr.requestSerializer.timeoutInterval = 30;
//    }
//    //2.发送请求
//    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if(success){
//             NSDictionary *get = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            success(get);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(operation,error);
//        }
//    }];
//
//
//}

//update 3.0
+ (void)post:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPSessionManager *)mgr success:(void (^)(id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    //1.创建请求管理者
    if (!mgr) {
        //        mgr=[AFHTTPRequestOperationManager manager];//2.0
        mgr = [AFHTTPSessionManager manager]; //3.0

        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 30;
    }
    //2.发送请求
    //    [mgr POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
    //        if(success){
    //            NSDictionary *get = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    //            success(get);
    //        }
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        if (failure) {
    //            failure(task,error);
    //        }
    //    }];

    [mgr POST:url parameters:params progress:^(NSProgress *_Nonnull uploadProgress) {

    }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            if (success) {
                NSDictionary *get = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(get);
            }
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            if (failure) {
                failure(task, error);
            }
        }];
}

//2.0
//+(void)post:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr constructingBodyWithBlock:(void (^)(id  formData))constructingBodyWithBlock  success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure{
//
//    //1.创建请求管理者
//    if (!mgr) {
//        mgr=[AFHTTPRequestOperationManager manager];
//        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
//        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//        mgr.requestSerializer.timeoutInterval = 30;
//    }    //2.发送请求
//    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        constructingBodyWithBlock(formData);
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if(success){
//            NSDictionary *get = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            success(get);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

//update3.0
+ (void)post:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPSessionManager *)mgr constructingBodyWithBlock:(void (^)(id formData))constructingBodyWithBlock success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {

    //1.创建请求管理者
    if (!mgr) {
        mgr = [AFHTTPSessionManager manager];
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 30;
    }
    //2.发送请求
    //    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        constructingBodyWithBlock(formData);
    //    } success:^(NSURLSessionDataTask *task, id responseObject) {
    //        if(success){
    //            NSDictionary *get = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    //            success(get);
    //        }
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        if (failure) {
    //            failure(error);
    //        }
    //    }];

    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        constructingBodyWithBlock(formData);
    }
        progress:^(NSProgress *_Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
            if (success) {
                NSDictionary *get = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(get);
            }
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            if (failure) {
                failure(error);
            }

        }];
}

#pragma mark - 微信登陆
//
//+(void)weChatLogin:(NSString *)code result:(void(^)(NSDictionary *getDic))result failure:(void(^)())failure{
//
//    NSString *api  = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",
//                      WXAppID,
//                      WXAppSecret,
//                      code];
//    [WTNetworking get:api params:nil success:^(id responseObject) {
//        NSDictionary *getDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *api1 = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",getDic[@"access_token"],getDic[@"openid"]];
//        [WTNetworking get:api1 params:nil success:^(id responseObject) {
//            NSDictionary *getDic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            result(getDic1);
//
//        } failure:^(NSError *error) {
//            failure();
//        }];
//    } failure:^(NSError *error) {
//        failure();
//    }];
//
//
//}

//
//+(void)weChatLogin:(NSString *)code result:(void(^)(NSDictionary *getDic))result failure:(void(^)())failure{
//
//    NSString *api  = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",
//                      WXAppID,
//                      WXAppSecret,
//                      code];
//    [WTNetworking get:api params:nil success:^(id responseObject) {
//        NSDictionary *getDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *api2 = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",
//                          WXAppID,
//                          getDic[@"refresh_token"]];
//
//        [WTNetworking get:api2 params:nil success:^(id responseObject) {
//            NSDictionary *getDic2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSString *api3 = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",getDic2[@"access_token"],getDic2[@"openid"]];
//            [WTNetworking get:api3 params:nil success:^(id responseObject) {
//                NSDictionary *getDic3 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                result(getDic3);
//
//            } failure:^(NSError *error) {
//                failure();
//            }];
//        } failure:^(NSError *error) {
//            failure();
//        }];
//    } failure:^(NSError *error) {
//        failure();
//    }];
//
//}

@end
