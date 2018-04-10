//
//  RecordView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordViewDelegate<NSObject>

@optional

- (void)recordViewDidEndRecord;

@end

@interface RecordView : UIView

@property (nonatomic, weak) id<RecordViewDelegate> delegate;

+ (instancetype)recordViewWithFrame:(CGRect)frame;

@end
