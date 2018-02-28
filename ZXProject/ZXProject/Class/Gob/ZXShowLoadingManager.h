//
//  ZXShowLoadingManager.h
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXShowLoadingManager : NSObject

+ (instancetype)sharedShowLaodingManager;

- (void)showLoadingInView:(UIView *)view andText:(NSString *)text;

- (void)hideLoadingView;

@end
