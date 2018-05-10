//
//  ProjectReviewDeviceCell.h
//  ZXProject
//
//  Created by Me on 2018/5/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProjectReviewDeviceCellDelegate<NSObject>

@optional

- (void)projectReviewDeviceCellDidClickBtnTag:(int)index andModelDict:(NSDictionary *)modelDict;

@end

@interface ProjectReviewDeviceCell : UITableViewCell

@property (nonatomic, weak) id<ProjectReviewDeviceCellDelegate>delegate;
@property (nonatomic, strong) NSDictionary *modelDict;

+ (instancetype)projectReviewDeviceCellWithTableView:(UITableView *)tableView;

@end
