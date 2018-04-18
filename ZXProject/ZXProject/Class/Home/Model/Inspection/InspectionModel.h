//
//  InspectionModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/18.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "BaseViewController.h"

@interface InspectionModel : NSObject

@property (nonatomic, assign) int patrolrecordid;//巡检记录id
@property (nonatomic, assign) long patroldate;//巡检日期
@property (nonatomic, assign) double positionlon;//经度
@property (nonatomic, assign) double positionlat;//纬度
@property (nonatomic, copy) NSString *positionaddress;//地址说明
@property (nonatomic, copy) NSString *regionid;
@property (nonatomic, copy) NSString *regionname;
@property (nonatomic, copy) NSString *orgid;
@property (nonatomic, copy) NSString *orgname;
@property (nonatomic, copy) NSString *employerid;
@property (nonatomic, copy) NSString *employername;
@property (nonatomic, copy) NSString *liableemployerid;
@property (nonatomic, copy) NSString *liableemployename;
@property (nonatomic, copy) NSString *photourl;
@property (nonatomic, copy) NSString *videourl;
@property (nonatomic, copy) NSString *soundurl;
@property (nonatomic, copy) NSString *patroltname;//巡检名称
@property (nonatomic, copy) NSString *patroltcontent;//巡检内容
@property (nonatomic, assign) int patroltstatus;//巡检结果
@property (nonatomic, assign) int eventid;

@property (nonatomic, strong) NSString *occourtimeString;
@property (nonatomic, strong) NSArray *photoUrls;//照片url;


+ (NSArray *)inspectionModelsWithSource_arr:(NSArray *)source_arr;


@end
