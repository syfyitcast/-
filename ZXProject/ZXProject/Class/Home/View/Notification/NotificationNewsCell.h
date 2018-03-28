//
//  NotificationNewsCell.h
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"

@interface NotificationNewsCell : UITableViewCell

@property (nonatomic, strong) NotificationModel *model;
@property (nonatomic, assign) int cellType;

+ (instancetype)notificationCellWithTableView:(UITableView *)tableView;

@end
