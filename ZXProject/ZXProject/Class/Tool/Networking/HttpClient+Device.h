//
//  HttpClient+Device.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (Device)

+ (void)zx_httpClientToGetProjectDeviceInfoWithProjectid:(NSString *)projectid andSuccessBlock:(responseBlock)block;

@end
