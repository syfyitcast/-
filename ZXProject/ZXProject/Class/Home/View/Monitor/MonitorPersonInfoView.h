//
//  MonitorPersonInfoView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/27.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonitorPersonInfoView : UIView

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (nonatomic, strong) NSDictionary *dict;

+ (instancetype)monitorPersonInfoView;

@end
