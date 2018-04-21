//
//  DeviceInfoCell.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceInfoModel.h"

@interface DeviceInfoCell : UITableViewCell

@property (nonatomic, strong) DeviceInfoModel *model;

+ (instancetype)deviceInfoCellWithTableView:(UITableView *)tableView;

@end
