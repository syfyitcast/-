//
//  HttpClient+Common.h
//  ZXProject
//
//  Created by Me on 2018/4/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (Common)

+ (void)zx_httpCilentToGetWeatherWithCityName:(NSString *)cityName  andSuccessBlock:(responseBlock)block;

+ (void)zx_httpCilentToGetWeatherWithPosition:(NSString *)position andSuccessBlock:(responseBlock)block;

@end
