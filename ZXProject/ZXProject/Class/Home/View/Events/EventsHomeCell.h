//
//  EventsHomeCell.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/22.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eventsMdoel.h"

@interface EventsHomeCell : UITableViewCell

@property (nonatomic, strong) eventsMdoel *model;

+ (instancetype)eventsHomeCellWithTabelView:(UITableView *)tableView;

@end
