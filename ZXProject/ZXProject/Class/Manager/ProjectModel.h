//
//  ProjectModel.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject

@property (nonatomic, copy) NSString *projectid;//项目id
@property (nonatomic, copy) NSString *projectname;//项目名称
@property (nonatomic, copy) NSString *positionaddress;//所属地
@property (nonatomic, copy) NSString *projectmanager;//项目经理
@property (nonatomic, copy) NSString *manageremployerid;//项目经理id
@property (nonatomic, copy) NSString *createtime;//创建时间
@property (nonatomic, copy) NSString *creatuser;//创建人
@property (nonatomic, copy) NSString *projecttype;//项目类型
@property (nonatomic, copy) NSString *projectstatus;//项目状态

@property (nonatomic, copy) NSString *positionlon;//项目经度
@property (nonatomic, copy) NSString *positionlat;//项目纬度
@property (nonatomic, copy) NSString *provincename;//省
@property (nonatomic, copy) NSString *cityname;//市
@property (nonatomic, copy) NSString *districtname;//区




+ (NSArray *)projectModelsWithsource_arr:(NSArray *)source_arr;

@end
