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
#import <Masonry.h>

@interface WorkTaskCell()

@property (weak, nonatomic) IBOutlet UIImageView *workTaskIcon;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countTimeDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeCoutLabel;
@property (nonatomic, strong) UIImageView *draftIconView;

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

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addSubview:self.draftIconView];
    __weak typeof(self)  weakself = self;
    [self.draftIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.typeLabel.mas_centerX);
        make.bottom.equalTo(weakself.typeLabel.mas_top).offset(-15);
        make.size.mas_equalTo(CGSizeMake(28.5, 21));
    }];
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
        self.timeCoutLabel.hidden = NO;
        self.personLabel.hidden = NO;
        self.countTimeDesLabel.hidden = NO;
        self.draftIconView.hidden = YES;
    }else if (model.taskstatus == 99){
        self.typeLabel.text = @"草稿";
        self.typeLabel.backgroundColor = DRAFTBackgroudColor;
        self.timeCoutLabel.hidden = YES;
        self.personLabel.hidden = YES;
        self.countTimeDesLabel.hidden = YES;
        self.draftIconView.hidden = NO;
    }else if (model.taskstatus == 0){
        self.typeLabel.text = @"未完成";
        self.typeLabel.backgroundColor = [UIColor redColor];
        self.timeCoutLabel.hidden = NO;
        self.personLabel.hidden = NO;
        self.countTimeDesLabel.hidden = NO;
        self.draftIconView.hidden = YES;
    }
    NSTimeInterval chaTime = [[NSDate date] timeIntervalSince1970] - self.model.beforetime / 1000.0;
    int h = chaTime / 3600;
    int m = (chaTime - h * 3600) / 60;
    self.timeCoutLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",h,m];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NetworkConfig sharedNetworkingConfig].ipUrl,model.photoUrls.firstObject]];
    [self.workTaskIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"workTaskIcon"]];
}

- (void)setEventModel:(eventsMdoel *)eventModel{
    _eventModel = eventModel;
    self.personName.text =  [NSString stringWithFormat:@"发起人:%@",eventModel.createemployername];
    self.desLabel.text = [NSString stringWithFormat:@"说明:%@",eventModel.eventdescription];
    self.updateLabel.text = [NSString stringWithFormat:@"更新:%@",eventModel.occourtimeString];
    self.adressLabel.text = eventModel.positionaddress;
    if (eventModel.eventstatus == 2) {
        self.typeLabel.text = @"已完成";
        self.typeLabel.backgroundColor = BTNBackgroudColor;
        self.timeCoutLabel.hidden = NO;
        self.personLabel.hidden = NO;
        self.countTimeDesLabel.hidden = NO;
        self.draftIconView.hidden = YES;
    }else if (eventModel.eventstatus == 99){
        self.typeLabel.text = @"草稿";
        self.typeLabel.backgroundColor = DRAFTBackgroudColor;
        self.timeCoutLabel.hidden = YES;
        self.personLabel.hidden = YES;
        self.countTimeDesLabel.hidden = YES;
        self.draftIconView.hidden = NO;
    }else if (eventModel.eventstatus == 0){
        self.typeLabel.text = @"未完成";
        self.typeLabel.backgroundColor = [UIColor redColor];
        self.timeCoutLabel.hidden = NO;
        self.personLabel.hidden = NO;
        self.countTimeDesLabel.hidden = NO;
        self.draftIconView.hidden = YES;
    }
    NSTimeInterval chaTime = [[NSDate date] timeIntervalSince1970] - (eventModel.createtime/1000.0);
    int h = chaTime / 3600;
    int m = (chaTime - h * 3600) / 60;
    self.timeCoutLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",h,m];
    [self.workTaskIcon sd_setImageWithURL:eventModel.photoUrls.firstObject placeholderImage:[UIImage imageNamed:@"workTaskIcon"]];
}

- (void)setInspectionModel:(InspectionModel *)inspectionModel{
    _inspectionModel = inspectionModel;
    self.personName.text =  [NSString stringWithFormat:@"发起人:%@",inspectionModel.employername];
    self.desLabel.text = [NSString stringWithFormat:@"说明:%@",inspectionModel.patroltcontent];
    self.updateLabel.text = [NSString stringWithFormat:@"更新:%@",inspectionModel.occourtimeString];
    self.adressLabel.text = inspectionModel.positionaddress;
    if (inspectionModel.patroltstatus == 2) {
        self.typeLabel.text = @"已完成";
        self.typeLabel.backgroundColor = BTNBackgroudColor;
        self.timeCoutLabel.hidden = NO;
        self.personLabel.hidden = NO;
        self.countTimeDesLabel.hidden = NO;
        self.draftIconView.hidden = YES;
    }else if (inspectionModel.patroltstatus == 99){
        self.typeLabel.text = @"草稿";
        self.typeLabel.backgroundColor = DRAFTBackgroudColor;
        self.timeCoutLabel.hidden = YES;
        self.personLabel.hidden = YES;
        self.countTimeDesLabel.hidden = YES;
        self.draftIconView.hidden = NO;
    }else if (inspectionModel.patroltstatus == 0){
        self.typeLabel.text = @"未完成";
        self.typeLabel.backgroundColor = [UIColor redColor];
        self.timeCoutLabel.hidden = NO;
        self.personLabel.hidden = NO;
        self.countTimeDesLabel.hidden = NO;
        self.draftIconView.hidden = YES;
    }
    NSTimeInterval chaTime = [[NSDate date] timeIntervalSince1970] - (inspectionModel.patroldate/1000.0);
    int h = chaTime / 3600;
    int m = (chaTime - h * 3600) / 60;
    self.timeCoutLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",h,m];
    [self.workTaskIcon sd_setImageWithURL:inspectionModel.photoUrls.firstObject placeholderImage:[UIImage imageNamed:@"workTaskIcon"]];
}

- (UIImageView *)draftIconView{
    if (_draftIconView == nil) {
        _draftIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"draftIcon"]];
        _draftIconView.hidden = YES;
    }
    return _draftIconView;
}

@end
