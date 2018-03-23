//
//  ZXDatePickerView.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/23.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ZXDatePickerView.h"

@implementation ZXDatePickerView

+ (instancetype)zxDatePickView{
    ZXDatePickerView *view = [[ZXDatePickerView alloc] init];
    [view setConfig];
    return view;
}

- (void)setConfig{
    self.minuteInterval = 1;
    
    
}

@end
