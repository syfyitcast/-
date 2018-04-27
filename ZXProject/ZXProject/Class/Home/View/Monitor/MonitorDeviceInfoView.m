//
//  MonitorDeviceInfoView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/27.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MonitorDeviceInfoView.h"
#import "GobHeaderFile.h"

@interface MonitorDeviceInfoView()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;


@end

@implementation MonitorDeviceInfoView

+ (instancetype)monitorDeviceInfoView{
    return [[NSBundle mainBundle] loadNibNamed:@"MonitorDeviceInfoView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 12;
    self.layer.borderColor = BTNBackgroudColor.CGColor;
    self.layer.borderWidth = 1;
}


- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.nameLabel.text = dict[@"facilitytypename"];
    self.codeLabel.text = dict[@"facilityid"];
    self.positionLabel.text = dict[@"positionaddress"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dict[@"gpstime"] doubleValue] /  1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate:date];
    switch ([dict[@"workstatus"] intValue]) {
        case 0:
            self.statusLabel.text = @"在用";
            break;
        case 1:
            self.statusLabel.text = @"停用";
            break;
        case 2:
            self.statusLabel.text = @"报废";
            break;
        case 3:
            self.statusLabel.text = @"维修";
            break;
            
        default:
            break;
    }
    
}

@end
