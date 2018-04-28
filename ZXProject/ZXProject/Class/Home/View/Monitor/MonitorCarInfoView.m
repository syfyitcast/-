//
//  MonitorCarInfoView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "MonitorCarInfoView.h"
#import "GobHeaderFile.h"
#import "MonitorCarInfoSelecedView.h"

@interface MonitorCarInfoView()

@property (weak, nonatomic) IBOutlet UILabel *carnoLabel;

@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobilenoLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *posotionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) MonitorCarInfoSelecedView *selecedView;

@end

@implementation MonitorCarInfoView

+ (instancetype)monitorCarInfoView{
    return [[NSBundle mainBundle] loadNibNamed:@"MonitorCarInfoView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 12;
    self.layer.borderColor = BTNBackgroudColor.CGColor;
    self.layer.borderWidth = 1;
    CGFloat x = (self.width - 120)*0.5;
    CGFloat y = self.height - 25 - 5;
    CGFloat width = 120;
    CGFloat height = 25;
    self.selecedView = [MonitorCarInfoSelecedView monitorCarInfoSelecedViewWithItems:@[@"轨迹",@"工况",@"油耗",@"报警"] andFrame:CGRectMake(x,y , width, height)];
}

@end
