//
//  DeviceCollectionView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "DeviceCollectionView.h"

@interface DeviceCollectionView()

@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ddateLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *deviceCodeFiled;
@property (weak, nonatomic) IBOutlet UITextField *deviceNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *RFIDfiled;

@end

@implementation DeviceCollectionView

+ (instancetype)deviceCollectionView{
    return [[NSBundle mainBundle] loadNibNamed:@"DeviceCollectionView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.positionLabel.numberOfLines = 0;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    self.ddateLabel.text = [formatter stringFromDate:date];
}

- (void)setPositionAdress:(NSString *)positionAdress{
    self.positionLabel.text = positionAdress;
}

@end
