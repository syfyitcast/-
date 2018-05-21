//
//  ProjectReviewPersonCell.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/16.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectReviewPersonCell.h"
#import "GobHeaderFile.h"

@interface ProjectReviewPersonCell()

@property (weak, nonatomic) IBOutlet UIView *iconBgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *userrankLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ProjectReviewPersonCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconBgView.layer.cornerRadius = 33.5;
    self.iconBgView.layer.borderColor = UIColorWithFloat(239).CGColor;
    self.iconBgView.layer.borderWidth = 1;
    self.statusLabel.layer.cornerRadius = 6;
    self.statusLabel.clipsToBounds = YES;
}

+ (instancetype)projectReviewPersonCellWithTabelView:(UITableView *)tableView{
    static NSString *ID = @"ProjectReviewPersonCell";
    ProjectReviewPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProjectReviewPersonCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setModelDict:(NSDictionary *)modelDict{
    _modelDict = modelDict;
    self.userrankLabel.text = modelDict[@"userrank"];
    self.companyLabel.text = modelDict[@"companyname"];
    self.statusLabel.text = modelDict[@"workstatus"];
    self.positionLabel.text = modelDict[@"positionaddress"];
    self.nameLabel.text = modelDict[@"employername"];
    double time = [modelDict[@"gpstime"] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [dateFormatter stringFromDate:date];
    self.mobileNumLabel.text = modelDict[@"mobileno"];
}

@end
