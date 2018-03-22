//
//  WorkFlowCell.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowCell.h"

@interface WorkFlowCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *personName;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UILabel *apprvLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLbel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation WorkFlowCell

+ (instancetype)workFlowCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"WorkFlowCell";
    WorkFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"WorkFlowCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setModel:(WorkFlowModel *)model{
    _model = model;
    switch (model.eventtype) {
        case 1:
            self.iconView.image = [UIImage imageNamed:@"workFlowQJ"];
            break;
        case 2:
            self.iconView.image = [UIImage imageNamed:@"workFlowBX"];
            break;
        case 3:
            self.iconView.image = [UIImage imageNamed:@"workFlowCB"];
            break;
        case 4:
            self.iconView.image = [UIImage imageNamed:@"workFlowCC"];
            break;
        default:
            break;
    }
    self.personName.text = [NSString stringWithFormat:@"发起人: %@",model.eventemployername];
    self.typeLabel.text = [NSString stringWithFormat:@"流程类别: %@",model.typeName];
    self.updateLabel.text = [NSString stringWithFormat:@"发起时间 :%@",model.updateTimeString];
    self.apprvLabel.text = [NSString stringWithFormat:@"审批人: %@",model.localhandlername];
}


@end
