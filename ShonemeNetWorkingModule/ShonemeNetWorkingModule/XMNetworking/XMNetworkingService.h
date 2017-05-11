//
//  XMNetworkingService.h
//  ShonemeNetWorkingModule
//
//  Created by 薛坤龙 on 2017/5/10.
//  Copyright © 2017年 xm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMNetworkingService : NSObject

/**
 *  共享的单例对象
 */
+ (XMNetworkingService *)sharedService;


/**
 调用远程接口通用方法

 @param url 接口api
 @param params 参数
 @param success 数据请求成功
 @param code    数据请求失败
 @param failure 系统请求api失败
 */
- (void)connectRemoteUrl:(NSString *)url withParameters:(NSDictionary *)params success:(void (^)(id JSON))success codeFailure:(void (^)(id JSON))code failure:(void (^)(NSString *errorMsg))failure;

@end
