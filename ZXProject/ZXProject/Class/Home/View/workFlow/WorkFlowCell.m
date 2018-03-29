//
//  WorkFlowCell.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkFlowCell.h"
#import "GobHeaderFile.h"

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

- (void)awakeFromNib{
    [super awakeFromNib];
    self.statusLabel.layer.cornerRadius = 6;
    self.statusLabel.clipsToBounds = YES;
}

- (void)setModel:(WorkFlowModel *)model{
    _model = model;
    switch (model.flowtype) {
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
    self.timeLbel.text = model.countTime;
    switch (model.eventType) {
        case 4://草稿
            self.statusLabel.text = @"草稿";
            self.statusLabel.backgroundColor = DRAFTBackgroudColor;
            break;
        case 1:
            self.statusLabel.text = @"未完成";
            self.statusLabel.backgroundColor = [UIColor redColor];
            break;
        case 2:
            self.statusLabel.text = @"已完成";
            self.statusLabel.backgroundColor = BTNBackgroudColor;
            break;
        case 3:
            self.statusLabel.text = @"下一步";
            self.statusLabel.backgroundColor = BTNBackgroudColor;
            break;
        default:
            break;
    }
}


@end
