//
//  HttpClient+UploadFile.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient+UploadFile.h"
#import "NSNULL+Filtration.h"



@implementation HttpClient (UploadFile)

+ (void)zx_httpClientToUploadFileWithData:(NSData *)fileData andType:(UploadFileType)type andSuccessBlock:(responseBlock)block{
    NSMutableDictionary *params = [NetworkConfig networkConfigTokenWithMethodName:API_UPLOADFILE];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //2.上传文件
    NSString *url = [NetworkConfig appendPulicParamterWithApiUrl:API_UPLOADFILE withDict:params];
    NSString *key = @"";
    if (type == UploadFileTypePhoto) {
        key = @"photourl";
    }else if (type == UploadFileTypeVideo){
        key = @"videourl";
    }else if (type == UPloadFileTypeSound){
        key = @"soundurl";
    }
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //上传文件参数
        [formData appendPartWithFileData:fileData name:key fileName:@"image.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSDictionary *dict = (NSDictionary *)responseObject;
        int code = [dict[@"code"] intValue];
        NSString *meassage = dict[@"codedes"];
        NSDictionary *datas = dict[@"datas"];
        NSArray *arr = datas[@"getuploadfileurl"];
        block(code,arr.firstObject,meassage,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        block(-1,nil,nil,error);
        
    }];
}



@end
