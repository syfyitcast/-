//
//  HttpClient+WorkTask.h
//  ZXProject
//
//  Created by Me on 2018/4/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (WorkTask)

//获取环卫作业区域
+ (void)zx_httpClientToGetWorkTaskPointProjectoRgregionWithPosition:(NSString *)position andSuccessBlock:(responseBlock)block;

@end
