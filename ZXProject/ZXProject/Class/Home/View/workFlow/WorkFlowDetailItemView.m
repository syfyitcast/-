//
//  WorkFlowDetailItemView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/2.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailItemView.h"
#import "GobHeaderFile.h"

@interface WorkFlowDetailItemView()

@property (weak, nonatomic) IBOutlet UILabel *userrankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *approvNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation WorkFlowDetailItemView

+ (instancetype)workFlowDetailItemView{
    return [[NSBundle mainBundle] loadNibNamed:@"WorkFlowDetailItemView" owner:nil options:nil].lastObject;
}

+ (instancetype)workFlowDetailEndItemView{
    WorkFlowDetailItemView *view = [self workFlowDetailItemView];
    view.userrankNameLabel.hidden = YES;
    view.timeLabel.hidden = YES;
    view.approvNameLabel.text = @"结束";
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(workFlowApprovItemViewDidTapItem:)]) {
        [self.delegate workFlowApprovItemViewDidTapItem:self];
    }
}

- (void)setModel:(WorkFlowApprovModel *)model{
    _model = model;
    self.userrankNameLabel.text = model.userrank;
    self.approvNameLabel.text = model.employername;
    if (model.submittime == 0) {
        NSTimeInterval time = model.receivetime / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        self.timeLabel.text = [formatter stringFromDate:date];
    }else{
        NSTimeInterval time = model.submittime / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        self.timeLabel.text = [formatter stringFromDate:date];
    }
    if (self.model.isCurrentModel) {
        self.approvNameLabel.layer.cornerRadius = 18;
        self.approvNameLabel.backgroundColor = UIColorWithRGB(203, 243, 170);
        self.approvNameLabel.layer.borderWidth = 0.5;
        self.approvNameLabel.layer.borderColor = UIColorWithFloat(239).CGColor;
        self.approvNameLabel.clipsToBounds = YES;
    }
}


@end
