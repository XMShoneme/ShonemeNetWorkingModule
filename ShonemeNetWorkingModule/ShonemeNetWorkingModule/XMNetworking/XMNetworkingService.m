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

@end
