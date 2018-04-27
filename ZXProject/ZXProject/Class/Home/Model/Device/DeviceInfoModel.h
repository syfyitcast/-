//
//  DeviceInfoModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfoModel : NSObject

@property (nonatomic, copy) NSString *facilityid;//设施id
@property (nonatomic, copy) NSString *facilitycode;//设施代码
@property (nonatomic, copy) NSString *facilityname;//设施名称
@property (nonatomic, copy) NSString *facilitytypename;//设施类型名称
@property (nonatomic, copy) NSString *positionlon;//位置经度
@property (nonatomic, copy) NSString *positionlat;//位置纬度
@property (nonatomic, copy) NSString *positionaddress;//位置描述
@property (nonatomic, copy) NSString *photourl;//图片链接
@property (nonatomic, copy) NSString *facilitytype;//设施类型
@property (nonatomic, assign) int workstatus;//工作状态 0.在用 1.停用 2.报废 3.维修
@property (nonatomic, copy) NSString *rfidcount;//rfid标签桶钩取次数
@property (nonatomic, assign) long gpstime;//上传时间
@property (nonatomic, copy) NSString *icon;//图标
@property (nonatomic, assign) int isfocus;//是否重点关注 0.否 1.是
@property (nonatomic, assign) int isvideo;//是否视频监控 0.否 1.是
@property (nonatomic, copy) NSString *videourl;//视频页面
@property (nonatomic, assign) int ispublic;//是否公共设施 0.否 1.是
@property (nonatomic, assign) int isparking;//是否停车区域 0.否 1.是
@property (nonatomic, copy) NSString *parkingradius;//停车半径
@property (nonatomic, copy) NSString *isbusinessstation;//是否运营场站 0.否 1.是

@property (nonatomic, copy) NSString *updateTimeString;//时间字符串
@property (nonatomic, strong) NSArray *photoUrls;

+ (NSArray *)deviceInfoModelsWithSource_arr:(NSArray *)source_arr;













@end
