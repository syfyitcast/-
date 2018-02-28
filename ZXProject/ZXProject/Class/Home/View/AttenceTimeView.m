//
//  AttenceTimeView.m
//  ZXProject
//
//  Created by Me on 2018/2/28.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "AttenceTimeView.h"
#import "GobHeaderFile.h"

@implementation AttenceTimeView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.iconBgView.layer.cornerRadius = 25;
    self.iconBgView.layer.borderColor = UIColorWithRGB(215, 215, 215).CGColor;
    self.iconBgView.layer.borderWidth = 1;
    self.typeBtn.layer.cornerRadius = 3;
    self.typeBtn.clipsToBounds = YES;
}

+ (instancetype)attenceTimeView{
    AttenceTimeView *view = [[NSBundle mainBundle] loadNibNamed:@"AttenceTimeView" owner:nil options:nil].lastObject;
    
    return view;;
}

@end
