//
//  NewsReadListCell.h
//  ZXProject
//
//  Created by Me on 2018/5/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsReadListCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *model;
@property (nonatomic, assign) int index;

+ (instancetype)newsReadListCellWithTableView:(UITableView *)tableView;

@end
