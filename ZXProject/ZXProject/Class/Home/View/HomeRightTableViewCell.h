//
//  HomeRightTableViewCell.h
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeRightItems.h"

@interface HomeRightTableViewCell : UITableViewCell

@property (nonatomic, strong) HomeRightItems *item;

+ (instancetype)homeRightTableViewCellWithTable:(UITableView *)table;

@end

