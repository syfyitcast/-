//
//  AttenceHeaderView.h
//  ZXProject
//
//  Created by Me on 2018/2/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttenceHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UIButton *dkBtn;
@property (weak, nonatomic) IBOutlet UIView *iconBgView;

+ (instancetype)attenceHeaderView;

@end
