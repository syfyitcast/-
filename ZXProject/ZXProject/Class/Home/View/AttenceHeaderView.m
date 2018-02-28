//
//  AttenceHeaderView.m
//  ZXProject
//
//  Created by Me on 2018/2/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttenceHeaderView.h"
#import "GobHeaderFile.h"

@implementation AttenceHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconBgView.layer.cornerRadius = 25;
    self.iconBgView.layer.borderColor = UIColorWithRGB(200, 200, 200).CGColor;
    self.iconBgView.layer.borderWidth = 1;
    self.dkBtn.layer.cornerRadius = 6;
}

+ (instancetype)attenceHeaderView{
    AttenceHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"AttenceHeaderView" owner:nil options:nil].lastObject;
    return headerView;
   
}

@end
