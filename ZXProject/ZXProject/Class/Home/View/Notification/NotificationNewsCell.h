//
//  NotificationNewsCell.h
//  ZXProject
//
//  Created by Me on 2018/2/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"

@protocol NotificaionNewsCellDelegate<NSObject>

@optional

- (void)notificationNewsCellDidClickReadInfoWithNotificationModel:(NotificationModel *)model;

@end

@interface NotificationNewsCell : UITableViewCell

@property (nonatomic, strong) NotificationModel *model;
@property (nonatomic, assign) int cellType;
@property (nonatomic, weak) id <NotificaionNewsCellDelegate>delegate;

+ (instancetype)notificationCellWithTableView:(UITableView *)tableView;

@end
