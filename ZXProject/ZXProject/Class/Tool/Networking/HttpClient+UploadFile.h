//
//  HttpClient+UploadFile.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

typedef enum {
    UploadFileTypePhoto = 0,
    UploadFileTypeVideo,
    UPloadFileTypeSound
}UploadFileType;

@interface HttpClient (UploadFile)

+ (void)zx_httpClientToUploadFileWithData:(NSData *)fileData andType:(UploadFileType)type andSuccessBlock:(responseBlock)block;

//下载文件
+ (void)zx_httpClientToDownloadFileWithUrl:(NSString *)url andDestinationPath:(NSString *)path andSuccessBlock:(responseBlock)block;

@end
