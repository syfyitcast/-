//
//  HttpClient+Inspection.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+Inspection.h"
#import "NSNULL+Filtration.h"
#import "ProjectManager.h"
#import "UserManager.h"

@implementation HttpClient (Inspection)

+ (void)zx_httpClinetToGetPatrolReportWithProjectId:(NSString *)projectid andPatroltstatus:(long)status andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *dict =  [NetworkConfig networkConfigTokenWithMethodName:API_GETINSPECTION];
    [dict setObject:projectid forKey:@"projectid"];
    [dict setObject:@(status) forKey:@"patroltstatus"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETINSPECTION];
        request.httpMethod           = kXMHTTPMethodPOST;
        request.parameters =         dict;
        request.timeoutInterval      = 30;
        request.useGeneralHeaders    = YES;
        request.useGeneralServer     = YES;
        request.useGeneralParameters = NO;
    } onSuccess:^(id  _Nullable responseObject) {
        id responseObjectNoNull = [responseObject filterNullObject];
        int resultCode = [responseObjectNoNull[@"code"] intValue];
        id data = responseObjectNoNull[@"datas"];
        NSString *message = responseObjectNoNull[@"codedes"];
        block(resultCode,data,message,nil);
    } onFailure:^(NSError * _Nullable error) {
        block(-1,nil,nil,error);
    }];
}

@end
