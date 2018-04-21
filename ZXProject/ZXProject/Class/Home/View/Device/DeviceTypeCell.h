//
//  DeviceTypeCell.h
//  ZXProject
//
//  Created by Me on 2018/4/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceTypeCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *modelDict;
@property (nonatomic, assign) int index;

+ (instancetype)deviceTypeCellWithTableView:(UITableView *)tableView;

@end
