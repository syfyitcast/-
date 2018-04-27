//
//  MonitorPointAnnotation.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/26.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MonitorPointAnnotation : MAPointAnnotation

@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSDictionary *modelDict;

@end
