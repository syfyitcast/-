//
//  HomeLeftTableViewCell.h
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLeftTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *title;

+ (instancetype)homeLeftTableViewCellWithTableView:(UITableView *)tableView;

@end
