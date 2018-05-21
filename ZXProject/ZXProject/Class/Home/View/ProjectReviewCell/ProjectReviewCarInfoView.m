//
//  ProjectReviewCarInfoView.m
//  ZXProject
//
//  Created by Me on 2018/5/12.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ProjectReviewCarInfoView.h"

@interface ProjectReviewCarInfoView()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *carnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *cartypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orginnoLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ProjectReviewCarInfoView

- (void)awakeFromNib{
    [super awakeFromNib];
}

+ (instancetype)projectReviewCarInfoView{
    return [[NSBundle mainBundle] loadNibNamed:@"ProjectReviewCarInfoView" owner:nil options:nil].lastObject;
}

- (void)setModelDict:(NSDictionary *)modelDict{
    _modelDict = modelDict;
}


@end
