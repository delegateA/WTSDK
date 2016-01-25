//
//  WTNetworking.m
//
//  Created by 张威庭 on 15/3/29.
//  Copyright (c) 2015年 张威庭. All rights reserved.
//

#import "WTNetworking.h"


@implementation WTNetworking
+(void)get:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    //1.创建请求管理者
    if (!mgr) {
        mgr=[AFHTTPRequestOperationManager manager];
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 30;
    }
    //2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}


+(void)post:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr success:(void (^)(id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure{
    
    //1.创建请求管理者
    if (!mgr) {
        mgr=[AFHTTPRequestOperationManager manager];
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 30;
    }
    //2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
             NSDictionary *Get = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(Get);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
    
    
}


+(void)post:(NSString *)url params:(NSDictionary *)params mgr:(AFHTTPRequestOperationManager *)mgr constructingBodyWithBlock:(void (^)(id  formData))constructingBodyWithBlock  success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    //1.创建请求管理者
    if (!mgr) {
        mgr=[AFHTTPRequestOperationManager manager];
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 30;
    }    //2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        constructingBodyWithBlock(formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            NSDictionary *Get = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(Get);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 微信登陆
//
//+(void)WeChatLogin:(NSString *)code result:(void(^)(NSDictionary *GetDic))result failure:(void(^)())failure{
//    
//    NSString *api  = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",
//                      WXAppID,
//                      WXAppSecret,
//                      code];
//    [WTHttpTool get:api params:nil success:^(id responseObject) {
//        NSDictionary *GetDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *api1 = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",GetDic[@"access_token"],GetDic[@"openid"]];
//        [WTHttpTool get:api1 params:nil success:^(id responseObject) {
//            NSDictionary *GetDic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            result(GetDic1);
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
//+(void)WeChatLogin:(NSString *)code result:(void(^)(NSDictionary *GetDic))result failure:(void(^)())failure{
//
//    NSString *api  = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",
//                      WXAppID,
//                      WXAppSecret,
//                      code];
//    [WTHttpTool get:api params:nil success:^(id responseObject) {
//        NSDictionary *GetDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *api2 = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",
//                          WXAppID,
//                          GetDic[@"refresh_token"]];
//
//        [WTHttpTool get:api2 params:nil success:^(id responseObject) {
//            NSDictionary *GetDic2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSString *api3 = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",GetDic2[@"access_token"],GetDic2[@"openid"]];
//            [WTHttpTool get:api3 params:nil success:^(id responseObject) {
//                NSDictionary *GetDic3 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                result(GetDic3);
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
