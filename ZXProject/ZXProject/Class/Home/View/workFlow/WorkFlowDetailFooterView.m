//
//  WorkFlowDetailFooterView.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/30.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowDetailFooterView.h"
#import "GobHeaderFile.h"
#import "WorkFlowDetailItemView.h"

@interface WorkFlowDetailFooterView()


@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

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

- (void)setApprovItem{
    //第一个item是申请人
    WorkFlowDetailItemView *item_0 = [WorkFlowDetailItemView workFlowDetailItemView];
    item_0.model = self.submitModel;
    CGFloat width = 100;//([UIScreen mainScreen].bounds.size.width - 2 * 28.5 ) / 3.0;
    CGFloat height = 100;
    item_0.x = 0;
    item_0.y = 0;
    item_0.width = width;
    item_0.height = height;
    [self.myScrollView addSubview:item_0];
    UIImageView *imageView_0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apprvoFlowAworr"]];
    imageView_0.x = CGRectGetMaxX(item_0.frame);
    imageView_0.width = 58.5;
    imageView_0.height = 28.5;
    imageView_0.y = (self.myScrollView.height - imageView_0.height) * 0.5;
    [self.myScrollView addSubview:imageView_0];
    for (int i = 1; i <= self.models.count - 1; i ++) {
        WorkFlowApprovModel *model = self.models[i];
        WorkFlowDetailItemView *item = [WorkFlowDetailItemView workFlowDetailItemView];
        item.model = model;
        item.x = CGRectGetMaxX(imageView_0.frame) + (i - 1) * width;
        item.y = 0;
        item.height = height;
        item.width = width;
        [self.myScrollView addSubview:item];
    }
}

- (void)setModels:(NSArray *)models{
    _models = models;
    self.submitModel = models.firstObject;
    for (WorkFlowApprovModel *model in _models) {
        if (model.submittime == 0 || model.submittimeStrin == nil) {
            self.currentModel = model;
            self.currentModel.isCurrentModel = YES;
        }
    }
    if (self.currentModel.opinion != nil) {
        self.apprvoResonTextView.text = self.currentModel.opinion;
    }
    [self setApprovItem];
}


@end
