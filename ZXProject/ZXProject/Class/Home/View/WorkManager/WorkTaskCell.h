//
//  WorkTaskCell.h
//  ZXProject
//
//  Created by Me on 2018/3/4.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkTaskModel.h"
#import "eventsMdoel.h"
#import "InspectionModel.h"

@interface WorkTaskCell : UITableViewCell

@property (nonatomic, strong) WorkTaskModel *model;
@property (nonatomic, strong) eventsMdoel *eventModel;
@property (nonatomic, strong) InspectionModel *inspectionModel;

+ (instancetype)workTaskCellWithTableView:(UITableView *)tableView;

@end
