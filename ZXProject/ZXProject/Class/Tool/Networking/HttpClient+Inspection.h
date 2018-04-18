//
//  HttpClient+Inspection.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (Inspection)

+ (void)zx_httpClinetToGetPatrolReportWithProjectId:(NSString *)projectid andPatroltstatus:(long)status andSuccessBlock:(responseBlock)block;

@end
