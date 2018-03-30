//
//  WorkFlowDetailFooterView.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/30.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailFooterView.h"
#import "GobHeaderFile.h"

@interface WorkFlowDetailFooterView()

@property (weak, nonatomic) IBOutlet UILabel *submiterRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *submiterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *submitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *approvRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *approvNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *approvTime;
@property (weak, nonatomic) IBOutlet UILabel *fnishedTime;

@property (weak, nonatomic) IBOutlet UILabel *approvLabel;
@property (weak, nonatomic) IBOutlet UILabel *apprvoStatusLabel;
@property (weak, nonatomic) IBOutlet UITextView *apprvoResonTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation WorkFlowDetailFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.apprvoResonTextView.layer.borderWidth = 1;
    self.apprvoResonTextView.layer.borderColor = UIColorWithFloat(239).CGColor;
}

+ (instancetype)workFlowDetailFooterView{
    return [[NSBundle mainBundle] loadNibNamed:@"WorkFlowDetailFooterView" owner:nil options:nil].lastObject;
}


@end
