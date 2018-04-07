//
//  AttenceCheckView.h
//  ZXProject
//
//  Created by Me on 2018/4/6.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttDutyCheckModel.h"

@interface AttenceCheckView : UITableViewCell

@property (nonatomic, strong) AttDutyCheckModel *model;

+ (instancetype)attenceCheckCellWithTableView:(UITableView *)tableView;

@end
