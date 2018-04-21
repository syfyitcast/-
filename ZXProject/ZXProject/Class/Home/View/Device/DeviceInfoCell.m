//
//  DeviceInfoCell.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceInfoCell.h"
#import "GobHeaderFile.h"
#import <UIImageView+WebCache.h>
#import "NetworkConfig.h"

@interface DeviceInfoCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceTyoeLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation DeviceInfoCell

+ (instancetype)deviceInfoCellWithTableView:(UITableView *)tableView{
    NSString *ID = @"DeviceInfoCell";
    DeviceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DeviceInfoCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.statusLabel.layer.cornerRadius = 4;
    self.statusLabel.clipsToBounds = YES;
    self.iconView.layer.cornerRadius = 30;
    self.iconView.layer.borderWidth = 1;
    self.iconView.layer.borderColor = UIColorWithFloat(239).CGColor;
}

#pragma mark - setter && getter

- (void)setModel:(DeviceInfoModel *)model{
    _model = model;
    self.deviceNameLabel.text = model.facilityname;
    self.deviceTyoeLabel.text = model.facilitycode;
    self.adressLabel.text = self.model.positionaddress;
    self.updateTimeLabel.text = [NSString stringWithFormat:@"更新:%@",self.model.updateTimeString];
    if (model.workstatus == 0) {
        self.statusLabel.text = @"使用中";
        self.statusLabel.backgroundColor = UIColorWithRGB(77, 202, 34);
    }else{
        self.statusLabel.text = @"未使用";
        self.statusLabel.backgroundColor = UIColorWithFloat(199);
    }
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:[NSString stringWithFormat:@"/hjwulian/%@",model.icon]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}



@end
