//
//  AttenceTimeView.h
//  ZXProject
//
//  Created by Me on 2018/2/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttenceTimeView : UIView

@property (weak, nonatomic) IBOutlet UIView *iconBgView;

@property (weak, nonatomic) IBOutlet UILabel *typeBtn;
@property (weak, nonatomic) IBOutlet UILabel *workLabel;
@property (weak, nonatomic) IBOutlet UILabel *offLabel;

+ (instancetype)attenceTimeView;

@end
