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



#define UIColorWithRGB(r,g,b)  [UIColor colorWithRed:r*1.0/255.0 green:g*1.0/255.0 blue:b*1.0/255.0 alpha:1]


#define WhiteColor UIColorWithRGB(255,255,255)
#define BlackColor UIColorWithRGB(0,0,0)



#define IS_UNDER_IPHONE5S [UIScreen mainScreen].bounds.size.width <= 320


#define ZXSHOW_LOADING(view,text)  [[ZXShowLoadingManager sharedShowLaodingManager] showLoadingInView:view andText:text];
#define ZXHIDE_LOADING             [[ZXShowLoadingManager sharedShowLaodingManager] hideLoadingView];

