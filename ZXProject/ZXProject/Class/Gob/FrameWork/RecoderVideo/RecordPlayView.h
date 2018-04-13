//
//  RecordPlayView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/11.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordPlayView : UIView

+ (instancetype)recordPlayViewWithPlayTime:(CGFloat)playTime andFrame:(CGRect)frame;

+ (instancetype)recordPlayViewWithUrl:(NSString *)url andFrame:(CGRect)frame;

@end
