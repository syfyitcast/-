//
//  ProjectReviewPersonDetailView.m
//  ZXProject
//
//  Created by Me on 2018/5/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectReviewPersonDetailView.h"

@interface ProjectReviewPersonDetailView()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userrankLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileno;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation ProjectReviewPersonDetailView

+ (instancetype)projectReviewPersonDetailView{
    return [[NSBundle mainBundle] loadNibNamed:@"ProjectReviewPersonDetailView" owner:nil options:nil].lastObject;
}

- (void)setModelDict:(NSDictionary *)modelDict{
    _modelDict = modelDict;
    self.nameLabel.text = modelDict[@"employername"];
    self.userrankLabel.text = modelDict[@"userrank"];
    self.mobileno.text = modelDict[@"mobileno"];
    self.positionLabel.text = modelDict[@"positionaddress"];
    double gpsTime = [modelDict[@"gpstime"] doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:gpsTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate:date];
}


@end
