//
//  HttpClient+Device.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient (Device)

//获取项目设施类型列表
+ (void)zx_httpClientToGetDeviceTypeListWithSuccessBlock:(responseBlock)block;

//获取项目设施
+ (void)zx_httpClientToGetProjectDeviceInfoWithProjectid:(NSString *)projectid andSuccessBlock:(responseBlock)block;

//新增项目设施
+ (void)zx_httpClientToAddfacilityWithFacilitycode:(NSString *)facilitycode andFacilityname:(NSString *)facilityname andFacilitytype:(NSString *)facilitytype andRfidtag:(NSString *)tag andPhotoUrl:(NSString *)photoUrl andPositionAdress:(NSString *)positionaddress andPositionlon:(double)positionlon andPositionlat:(double)positionlat andIsFocus:(int)isfocus
                                        andIsvideo:(int)isvideo andIspublic:(int)ispublic andSuccessBlock:(responseBlock)block;

//修改项目设施
+ (void)zx_httpClientToModifyFacilityWithFacilityid:(NSString *)facilityid andFacilityCode:(NSString *)facilitycode andFacilityname:(NSString *)facilityname andFacilitytype:(NSString *)facilitytype andWorkStatus:(int)workstatus andPhotourl:(NSString *)photoUrl
                                 andPositionaddress:(NSString *)positionAddress andPositionlon:(double)positionlon andPositionlat:(double)positionlat andIsfocus:(int)isfocus andIsvideo:(int)isvideo andIspublic:(int)ispublic andRFIDtag:(NSString *)rfidtag andSuccessBlock:(responseBlock)block;

@end
