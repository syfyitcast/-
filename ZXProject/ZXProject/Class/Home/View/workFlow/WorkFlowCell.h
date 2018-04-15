//
//  WorkFlowCell.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowModel.h"
#import "eventsMdoel.h"

@interface WorkFlowCell : UITableViewCell

@property (nonatomic, strong) WorkFlowModel *model;


+ (instancetype)workFlowCellWithTableView:(UITableView *)tableView;

@end
