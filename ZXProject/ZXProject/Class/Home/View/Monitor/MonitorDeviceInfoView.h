//
//  MonitorDeviceInfoView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/27.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonitorDeviceInfoView : UIView

@property (nonatomic, strong) NSDictionary *dict;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

+ (instancetype)monitorDeviceInfoView;

@end
