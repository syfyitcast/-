//
//  GobHeaderFile.h
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FButton.h"
#import "UIView+Layout.h"
#import "ZXShowLoadingManager.h"
#import "MBProgressHUD+PKX.h"



#define UIColorWithRGB(r,g,b)   [UIColor colorWithRed:r*1.0/255.0 green:g*1.0/255.0 blue:b*1.0/255.0 alpha:1]
#define UIColorWithFloat(float) [UIColor colorWithRed:float*1.0/255.0 green:float*1.0/255.0 blue:float*1.0/255.0 alpha:1]

#define WhiteColor UIColorWithRGB(255,255,255)
#define BlackColor UIColorWithRGB(0,0,0)

#define BTNBackgroudColor UIColorWithRGB(120, 200, 58)

#define kScreenRatioWidth   [UIScreen mainScreen].bounds.size.width / 375.0
#define kScreenRatioHeight  [UIScreen mainScreen].bounds.size.height / 667.0



#define IS_UNDER_IPHONE5S [UIScreen mainScreen].bounds.size.width <= 320


#define ZXSHOW_LOADING(view,text)  [[ZXShowLoadingManager sharedShowLaodingManager] showLoadingInView:view andText:text];
#define ZXHIDE_LOADING             [[ZXShowLoadingManager sharedShowLaodingManager] hideLoadingView];

