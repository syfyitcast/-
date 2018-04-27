//
//  MonitorPersonInfoView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/27.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MonitorPersonInfoView.h"
#import "GobHeaderFile.h"

@interface MonitorPersonInfoView()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *worknoLabel;
@property (weak, nonatomic) IBOutlet UILabel *userrankLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobilenoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dutyRegionLabel;
@property (weak, nonatomic) IBOutlet UILabel *workStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;


@end

@implementation MonitorPersonInfoView

+ (instancetype)monitorPersonInfoView{
    return [[NSBundle mainBundle] loadNibNamed:@"MonitorPersonInfoView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 12;
    self.layer.borderColor = BTNBackgroudColor.CGColor;
    self.layer.borderWidth = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMobileNo)];
    self.mobilenoLabel.userInteractionEnabled = YES;
    [self.mobilenoLabel addGestureRecognizer:tap];
}

- (void)tapMobileNo{
    if (self.mobilenoLabel.text.length == 0) {
        return;
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.mobilenoLabel.text]]];
    }
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.nameLabel.text = dict[@"employername"];
    self.userrankLabel.text = dict[@"userrank"];
    self.worknoLabel.text = dict[@"workno"];
    self.workStatusLabel.text = dict[@"workstatus"];
    self.mobilenoLabel.text = dict[@"mobileno"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dict[@"gpstime"] doubleValue] /  1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate:date];
    self.positionLabel.text = dict[@"positionaddress"];
    
}

@end
