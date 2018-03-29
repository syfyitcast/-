//
//  PersoninfoDeflutCell.h
//  ZXProject
//
//  Created by 刘清 on 2018/3/29.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersoninfoDeflutCell : UITableViewCell

@property (nonatomic, strong) NSDictionary  *mdoelDict;

+ (instancetype)personinfoDeflutCellWithTableView:(UITableView *)tableView;

- (void)hideBottomLine;

@end
