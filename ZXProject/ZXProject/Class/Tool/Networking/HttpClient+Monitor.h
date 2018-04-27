//
//  HttpClient+Monitor.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (Monitor)
//项目人员查询
+ (void)zx_httpClientToGetProjectPersonInfoWithProjectid:(NSString *)projectid andSuccessBlock:(responseBlock)block;

//项目车辆查询
+ (void)zx_httpClientToGetProjectCarInfoWithProjectid:(NSString *)projectid andSuccessBlock:(responseBlock)block;

@end
