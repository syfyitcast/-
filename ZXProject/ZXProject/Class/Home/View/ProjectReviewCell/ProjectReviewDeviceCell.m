//
//  ProjectReviewDeviceCell.m
//  ZXProject
//
//  Created by Me on 2018/5/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectReviewDeviceCell.h"
#import "MonitorCarInfoSelecedView.h"
#import <Masonry.h>
#import "GobHeaderFile.h"
#import "NetworkConfig.h"
#import <UIImageView+WebCache.h>
#import "NSString+boundSize.h"

@interface ProjectReviewDeviceCell()<MonitorCarInfoSelecedViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *carnoLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mapIcon;

@property (weak, nonatomic) IBOutlet UILabel *mannoLabel;

@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;

@property (nonatomic, strong) MonitorCarInfoSelecedView *selecedView;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@end

@implementation ProjectReviewDeviceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.selecedView];
    __weak typeof(self) weakself = self;
    [self.selecedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.mapIcon.mas_left);
        make.top.equalTo(weakself.mapIcon.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(150);
    }];
    self.carTypeLabel.backgroundColor = BTNBackgroudColor;
    self.carTypeLabel.layer.cornerRadius = 6;
    self.carTypeLabel.clipsToBounds = YES;
}

+ (instancetype)projectReviewDeviceCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"ProjectReviewDeviceCell";
    ProjectReviewDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProjectReviewDeviceCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)monitorCarInfoSelecedViewDidClickBtn:(int)index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(projectReviewDeviceCellDidClickBtnTag: andModelDict:)]) {
        [self.delegate projectReviewDeviceCellDidClickBtnTag:index andModelDict:self.modelDict];
    }
}

- (void)setModelDict:(NSDictionary *)modelDict{
    _modelDict = modelDict;
    self.carnoLabel.text = modelDict[@"vehlicense"];
    self.mannoLabel.text = modelDict[@"manufacturingno"];
    self.positionLabel.text = modelDict[@"positionaddress"];
    double gpstime = [modelDict[@"gpstime"] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:gpstime / 1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [formatter stringFromDate:date];
    self.carTypeLabel.text = modelDict[@"vehclassname"];
    NSURL *url = [NSURL URLWithString:[[NetworkConfig sharedNetworkingConfig].ipUrl stringByAppendingString:modelDict[@"photourl"]]];
    [self.iconView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    CGFloat width = [self.carTypeLabel.text boundSizeWithFont:self.carTypeLabel.font].width;
    _width.constant = width + 15;
}

- (MonitorCarInfoSelecedView *)selecedView{
    if (_selecedView == nil) {
        _selecedView = [MonitorCarInfoSelecedView monitorCarInfoSelecedViewWithItems:@[@"轨迹",@"工况",@"统计"] andFrame:CGRectMake(0, 0, 150, 25)];
        _selecedView.delegate = self;
    }
    return _selecedView;
}


@end
