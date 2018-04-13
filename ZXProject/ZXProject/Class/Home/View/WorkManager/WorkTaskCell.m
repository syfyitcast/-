//
//  WorkTaskCell.m
//  ZXProject
//
//  Created by Me on 2018/3/4.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskCell.h"
#import "GobHeaderFile.h"
#import "NetworkConfig.h"
#import <UIImageView+WebCache.h>

@interface WorkTaskCell()

@property (weak, nonatomic) IBOutlet UIImageView *workTaskIcon;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeCoutLabel;

@end;

@implementation WorkTaskCell

+ (instancetype)workTaskCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"WorkTaskCell";
    WorkTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"WorkTaskCell" owner:nil options:nil].lastObject;
        cell.typeLabel.layer.cornerRadius = 6;
        cell.typeLabel.clipsToBounds = YES;
    }
    return cell;
}

- (void)setModel:(WorkTaskModel *)model{
    _model = model;
    self.personName.text =  [NSString stringWithFormat:@"发起人:%@",model.submitemployername];
    self.desLabel.text = [NSString stringWithFormat:@"说明:%@",model.taskcontent];
    self.updateLabel.text = [NSString stringWithFormat:@"更新:%@",model.occurtime];
    self.adressLabel.text = model.positionaddress;
    if (model.taskstatus == 2) {
        self.typeLabel.text = @"已完成";
        self.typeLabel.backgroundColor = BTNBackgroudColor;
    }else if (model.taskstatus == 99){
        self.typeLabel.text = @"草稿";
        self.typeLabel.backgroundColor = UIColorWithRGB(59, 127, 159);
    }else if (model.taskstatus == 0){
        self.typeLabel.text = @"未完成";
        self.typeLabel.backgroundColor = [UIColor redColor];
    }
    NSTimeInterval chaTime = [[NSDate date] timeIntervalSince1970] - self.model.beforetime / 1000.0;
    int h = chaTime / 3600;
    int m = (chaTime - h * 3600) / 60;
    self.timeCoutLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",h,m];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NetworkConfig sharedNetworkingConfig].ipUrl,model.photoUrls.firstObject]];
    [self.workTaskIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"workTaskIcon"]];
}

@end
