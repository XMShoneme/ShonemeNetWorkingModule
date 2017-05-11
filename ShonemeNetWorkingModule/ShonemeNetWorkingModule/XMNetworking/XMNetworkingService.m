//
//  XMNetworkingService.m
//  ShonemeNetWorkingModule
//
//  Created by 薛坤龙 on 2017/5/10.
//  Copyright © 2017年 xm. All rights reserved.
//

#import "XMNetworkingService.h"
#import <AFNetworking/AFNetworking.h>

@implementation XMNetworkingService

+ (XMNetworkingService *)sharedService
{
    static XMNetworkingService *networkService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkService = [[self alloc] init];
    });
    return networkService;
}

- (void)connectRemoteUrl:(NSString *)url withParameters:(NSDictionary *)params success:(void (^)(id JSON))success codeFailure:(void (^)(id JSON))code failure:(void (^)(NSString *errorMsg))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         // 获取服务器响应数据
         NSString *responseStr =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSDictionary *JsonDic = [XMNetworkingService dictionaryWithJsonString:responseStr];
         
         NSLog(@"\n url：%@,\n params:%@,\n JsonDic:%@",url,params,JsonDic);
         
         if ([JsonDic isKindOfClass:[NSDictionary class]])
         {
             if ([JsonDic[@"result"] isEqualToString:@"success"])
             {
                 success(JsonDic);
                 
             }else if ([JsonDic[@"result"] isEqualToString:@"fail"])
             {
                 code(JsonDic);
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"Error: %@", error);
         NSString *errorMsg;
         if ([error.domain isEqualToString:@"AFNetworkingErrorDomain"] || [error.domain isEqualToString:@"NSURLErrorDomain"])
         {
             errorMsg = @"您已断开网络连接!";
         }else
         {
             errorMsg = @"系统异常";
         }
         failure(errorMsg);
     }];

}

/* json
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil)
    {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error)
    {
        return nil;
    }
    return dic;
}


@end
