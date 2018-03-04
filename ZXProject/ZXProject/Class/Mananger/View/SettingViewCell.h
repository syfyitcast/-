//
//  SettingViewCell.h
//  ZXProject
//
//  Created by Me on 2018/3/2.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewCell : UITableViewCell

@property (nonatomic, strong) NSString *title;

+ (instancetype)settingViewCellWithTableView:(UITableView *)table;

- (void)hideBottomLine;

@end
