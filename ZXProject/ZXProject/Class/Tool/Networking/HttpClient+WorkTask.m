//
//  HttpClient+WorkTask.m
//  ZXProject
//
//  Created by Me on 2018/4/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+WorkTask.h"
#import "NSNULL+Filtration.h"
#import "ProjectManager.h"
#import "UserManager.h"

@implementation HttpClient (WorkTask)

+ (void)zx_httpClientToGetWorkTaskPointProjectoRgregionWithPosition:(NSString *)position andSuccessBlock:(responseBlock)block{
    [NetworkConfig networkConfigTokenWithMethodName:API_GETPOINTPROJECTREGION];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[NetworkConfig sharedNetworkingConfig].publicParamters];
    [dict setObject:[ProjectManager sharedProjectManager].currentProjectid?[ProjectManager sharedProjectManager].currentProjectid:@"" forKey:@"projectid"];
    [dict setObject:position forKey:@"position"];
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.api                  = [NetworkConfig api:API_GETPOINTPROJECTREGION];
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
