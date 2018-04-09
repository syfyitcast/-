//
//  WorkTaskAddController.m
//  ZXProject
//
//  Created by Me on 2018/3/7.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "WorkTaskAddController.h"
#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"
#import "UserLocationManager.h"
#import "UIAlertAction+Attribute.h"
#import <Masonry.h>
#import "HttpClient+WorkTask.h"
#import "WorkTaskDetailModel.h"
#import "CGXStringPickerView.h"
#import "CGXPickerView.h"


@interface WorkTaskAddController()<WorkTaskAddImagePickViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) WorkTaskAddImagePickView *pickView;
@property (nonatomic, strong) UIView *lineOne;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton  *VoiceBtn;
@property (nonatomic, strong) UIView *lineTwo;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineThree;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UIImageView *positionIcon;
@property (nonatomic, strong) UIView *lineFour;
@property (nonatomic, strong) UILabel *dutyRegionLabel;
@property (nonatomic, strong) UILabel *dutyPersonLabel;
@property (nonatomic, strong) UIView  *lineFive;

@property (nonatomic, strong) UILabel *reslovPersonLabel;
@property (nonatomic, strong) FButton *reslovBtn;
@property (nonatomic, strong) UIView *lineSix;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) FButton *levelBtn;
@property (nonatomic, strong) UIView *lineSeven;
@property (nonatomic, strong) UILabel *isvehNeedLabel;
@property (nonatomic, strong) FButton *isvehNeedBtn;
@property (nonatomic, strong) UIView *lineEight;

@property (nonatomic, strong) FButton *saveBtn;
@property (nonatomic, strong) FButton *submitBtn;

@property (nonatomic, strong) NSArray *projectRegions;
@property (nonatomic, strong) WorkTaskDetailModel *currentModel;


@end

@implementation WorkTaskAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增事件";
    [self setNetworkRequest];
    
}

- (void)setNetworkRequest{
    [HttpClient zx_httpClientToGetProjectRegionListWithSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        if (code == 0) {
            NSArray *datas = data[@"projectorgregion"];
            self.projectRegions = [WorkTaskDetailModel workTaskDetailModelsWithSource_arr:datas];
            [self setSubViews];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserLocationManager sharedUserLocationManager].positionAdress != nil) {
        self.positionLabel.text = [NSString stringWithFormat:@"位置:%@",[UserLocationManager sharedUserLocationManager].positionAdress];
    }else{
        [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            self.positionLabel.text = [NSString stringWithFormat:@"位置:%@%@%@%@",state,city, subLocality, street];
        }];
    }
}

- (void)setSubViews{
    __weak typeof(self) weakself = self;
    [self.view addSubview:self.pickView];
    [self.view addSubview:self.lineOne];
    [self.view addSubview:self.desLabel];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.VoiceBtn];
    [self.view addSubview:self.lineTwo];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.lineThree];
    [self.view addSubview:self.positionLabel];
    [self.view addSubview:self.positionIcon];
    [self.view addSubview:self.lineFour];
    [self.view addSubview:self.dutyRegionLabel];
    [self.view addSubview:self.dutyPersonLabel];
    [self.view addSubview:self.lineFive];
    [self.view addSubview:self.reslovBtn];
    [self.view addSubview:self.reslovPersonLabel];
    [self.view addSubview:self.lineSix];
//    [self.view addSubview:self.levelLabel];
//    [self.view addSubview:self.levelBtn];
//    [self.view addSubview:self.isvehNeedLabel];
     [self.view addSubview:self.lineSeven];
//    [self.view addSubview:self.lineEight];
//    [self.view addSubview:self.isvehNeedBtn];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.saveBtn];
    [self.lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.pickView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineOne.mas_bottom).offset(15);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.desLabel.mas_left);
        make.right.equalTo(weakself.view.mas_right).offset(-36);
        make.top.equalTo(weakself.desLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(80);
    }];
    [self.VoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.textView.mas_right).offset(5);
        make.right.equalTo(weakself.view.mas_right).offset(-3);
        make.bottom.equalTo(weakself.textView.mas_bottom);
        make.height.mas_equalTo(26);
    }];
    [self.lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.textView.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineTwo.mas_bottom).offset(15);
    }];
    [self.lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.timeLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineThree.mas_bottom).offset(15);
        make.right.equalTo(weakself.view.mas_right).offset(-25);
    }];
    [self.positionIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.positionLabel.mas_right).offset(5);
        make.centerY.equalTo(weakself.positionLabel.mas_centerY);
    }];
    [self.lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.positionLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.reslovPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineFour.mas_bottom).offset(15);
    }];
    [self.reslovBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.reslovPersonLabel.mas_right).offset(30);
        make.centerY.equalTo(weakself.reslovPersonLabel.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [self.lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.reslovPersonLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.dutyRegionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineFive.mas_bottom).offset(15);
    }];
    [self.lineSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.dutyRegionLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    [self.dutyPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.lineSix.mas_bottom).offset(15);
    }];
//    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.view.mas_left).offset(15);
//        make.top.equalTo(weakself.lineSix.mas_bottom).offset(15);
//    }];
//    [self.levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.levelLabel.mas_right).offset(30);
//        make.centerY.equalTo(weakself.levelLabel.mas_centerY);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(30);
//    }];
    [self.lineSeven mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.dutyPersonLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
//    [self.isvehNeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.view.mas_left).offset(15);
//        make.top.equalTo(weakself.lineSeven.mas_bottom).offset(15);
//    }];
//    [self.isvehNeedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.isvehNeedLabel.mas_right).offset(30);
//        make.centerY.equalTo(weakself.isvehNeedLabel.mas_centerY);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(30);
//    }];
//    [self.lineEight mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.view.mas_left);
//        make.right.equalTo(weakself.view.mas_right);
//        make.top.equalTo(weakself.isvehNeedLabel.mas_bottom).offset(15);
//        make.height.mas_equalTo(1);
//    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(60);
        make.top.equalTo(weakself.lineSeven.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.view.mas_right).offset(-60);
        make.top.equalTo(weakself.lineSeven.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
}

#pragma mark - WorkTaskAddImageViewDelegateMethod

- (void)WorkTaskAddImagePickViewDidTapImageView{
    UIAlertController *alterVc = [UIAlertController alertControllerWithTitle:@"选择" message:@"请选择获取照片的方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController *pickVc = [[UIImagePickerController alloc] init];
    pickVc.delegate = self;
    UIAlertAction *alterAction_0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickVc.sourceType =  UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickVc animated:YES completion:nil];
        }
    }];
    UIAlertAction *alterAction_1 = [UIAlertAction actionWithTitle:@"从相册中获取照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:pickVc animated:YES completion:nil];
        }
    }];
    UIAlertAction *alterAction_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alterVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [alterAction_0 setTitleColor:UIColorWithFloat(49)];
    [alterAction_1 setTitleColor:UIColorWithFloat(49)];
    [alterAction_2 setTitleColor:UIColorWithRGB(245, 0, 0)];
    [alterVc addAction:alterAction_0];
    [alterVc addAction:alterAction_1];
    [alterVc addAction:alterAction_2];
    [self presentViewController:alterVc animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.pickView getImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
   [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ClickAction

- (void)clickAction:(FButton *)btn{
    NSMutableArray *arr = [NSMutableArray array];
    for (WorkTaskDetailModel *model in self.projectRegions) {
        [arr addObject:model.regionname];
    }
    [CGXPickerView showStringPickerWithTitle:@"责任区域和责任人" DataSource:arr DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        int index = [selectRow intValue];
        WorkTaskDetailModel *model = self.projectRegions[index];
        self.currentModel = model;
        [btn setTitle:model.regionname forState:UIControlStateNormal];
        self.dutyRegionLabel.text = [NSString stringWithFormat:@"责任区:  %@",model.orgname];
        self.dutyPersonLabel.text = [NSString stringWithFormat:@"责任人:  %@",model.employername];
    }];
}

#pragma mark - setter && getter

- (WorkTaskAddImagePickView *)pickView{
    if (_pickView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.width, 100);
        _pickView = [WorkTaskAddImagePickView workTaskAddImagePickViewWithFrame:frame];
        _pickView.delegate = self;
    }
    return _pickView;
}

- (UIView *)lineOne{
    if (_lineOne == nil) {
        _lineOne = [[UIView alloc] init];
        _lineOne.backgroundColor = UIColorWithFloat(239);
    }
    return _lineOne;
}

- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.textColor = UIColorWithFloat(79);
        _desLabel.font = [UIFont systemFontOfSize:15];
        _desLabel.text = @"说明:";
    }
    return _desLabel;
}

- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.layer.borderColor = UIColorWithFloat(239).CGColor;
        _textView.layer.borderWidth = 1;
    }
    return _textView;
}

- (UIButton *)VoiceBtn{
    if (_VoiceBtn == nil) {
        _VoiceBtn = [[UIButton alloc] init];
        [_VoiceBtn setBackgroundImage:[UIImage imageNamed:@"voiceIcon"] forState:UIControlStateNormal];
    }
    return _VoiceBtn;
}

- (UIView *)lineTwo{
    if (_lineTwo == nil) {
        _lineTwo = [[UIView alloc] init];
        _lineTwo.backgroundColor = UIColorWithFloat(239);
    }
    return _lineTwo;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorWithFloat(79);
        _timeLabel.font = [UIFont systemFontOfSize:15];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _timeLabel.text = [NSString stringWithFormat:@"时间:   %@", [formatter stringFromDate:[NSDate date]]];
    }
    return _timeLabel;
}

- (UIView *)lineThree{
    if (_lineThree == nil) {
        _lineThree = [[UIView alloc] init];
        _lineThree.backgroundColor = UIColorWithFloat(239);
    }
    return _lineThree;
}

- (UILabel *)positionLabel{
    if (_positionLabel == nil) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.textColor = UIColorWithFloat(79);
        _positionLabel.font = [UIFont systemFontOfSize:15];
        _positionLabel.numberOfLines = 0;
    }
    return _positionLabel;
}

- (UIImageView *)positionIcon{
    if (_positionIcon == nil) {
        _positionIcon = [[UIImageView alloc] init];
        _positionIcon.image = [UIImage imageNamed:@"mapIcon"];
    }
    return _positionIcon;
}

- (UIView *)lineFour{
    if (_lineFour == nil) {
        _lineFour = [[UIView alloc] init];
        _lineFour.backgroundColor = UIColorWithFloat(239);
    }
    return _lineFour;
}

- (UILabel *)dutyRegionLabel{
    if (_dutyRegionLabel == nil) {
        _dutyRegionLabel = [[UILabel alloc] init];
        _dutyRegionLabel.textColor = UIColorWithFloat(79);
        _dutyRegionLabel.font = [UIFont systemFontOfSize:15];
        _dutyRegionLabel.text = @"责任区:";
        ;
    }
    return _dutyRegionLabel;
}

- (UILabel *)dutyPersonLabel{
    if (_dutyPersonLabel == nil) {
        _dutyPersonLabel = [[UILabel alloc] init];
        _dutyPersonLabel.textColor = UIColorWithFloat(79);
        _dutyPersonLabel.font = [UIFont systemFontOfSize:15];
        _dutyPersonLabel.textAlignment = NSTextAlignmentRight;
        _dutyPersonLabel.text = @"责任人:";
    }
    return _dutyPersonLabel;
}

- (UIView *)lineFive{
    if (_lineFive == nil) {
        _lineFive = [[UIView alloc] init];
        _lineFive.backgroundColor = UIColorWithFloat(239);
    }
    return _lineFive;
}

- (UILabel *)reslovPersonLabel{
    if (_reslovPersonLabel == nil) {
        _reslovPersonLabel = [[UILabel alloc] init];
        _reslovPersonLabel.text = @"选择责任区与责任人:";
        _reslovPersonLabel.textColor = UIColorWithFloat(79);
        _reslovPersonLabel.font = [UIFont systemFontOfSize:15];
    }
    return _reslovPersonLabel;
}

- (FButton *)reslovBtn{
    if (_reslovBtn == nil) {
        _reslovBtn  = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
        _reslovBtn.layer.borderWidth = 1;
        [_reslovBtn  setTitle:@"请选择" forState:UIControlStateNormal];
        _reslovBtn.layer.borderColor = UIColorWithFloat(159).CGColor;
        _reslovBtn.backgroundColor = UIColorWithFloat(222);
        _reslovBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_reslovBtn  setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
        [_reslovBtn  setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
        [_reslovBtn  addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _reslovBtn.tag = 3;
    }
    return _reslovBtn ;
}

- (UIView *)lineSix{
    if (_lineSix == nil) {
        _lineSix = [[UIView alloc] init];
        _lineSix.backgroundColor = UIColorWithFloat(239);
    }
    return _lineSix;
}

- (UIView *)lineSeven{
    if (_lineSeven== nil) {
        _lineSeven = [[UIView alloc] init];
        _lineSeven.backgroundColor = UIColorWithFloat(239);
    }
    return _lineSeven;
}

- (FButton *)saveBtn{
    if (_saveBtn == nil) {
        _saveBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _saveBtn.backgroundColor = BTNBackgroudColor;
        _saveBtn.layer.cornerRadius = 6;
        [_saveBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.tag = 5;
    }
    return _saveBtn;
}

- (FButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [FButton fbtnWithFBLayout:FBLayoutTypeTextFull andPadding:0];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _submitBtn.backgroundColor = BTNBackgroudColor;
        _submitBtn.layer.cornerRadius = 6;
        [_submitBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.tag = 6;
    }
    return _submitBtn;
}

//- (FButton *)levelBtn{
//    if (_levelBtn == nil) {
//        _levelBtn  = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
//        _levelBtn.layer.borderWidth = 1;
//        [_levelBtn  setTitle:@"请选择" forState:UIControlStateNormal];
//        _levelBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
//        _levelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_levelBtn  setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
//        [_levelBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
//        [_levelBtn  addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        _levelBtn.tag = 3;
//    }
//    return _levelBtn;
//}
//
//- (UILabel *)isvehNeedLabel{
//    if (_isvehNeedLabel == nil) {
//        _isvehNeedLabel = [[UILabel alloc] init];
//        _isvehNeedLabel.text = @"车辆需求:";
//        _isvehNeedLabel.textColor = UIColorWithFloat(79);
//        _isvehNeedLabel.font = [UIFont systemFontOfSize:15];
//    }
//    return _isvehNeedLabel;
//}
//
//- (FButton *)isvehNeedBtn{
//    if (_isvehNeedBtn == nil) {
//        _isvehNeedBtn = [FButton fbtnWithFBLayout:FBLayoutTypeRight andPadding:5];
//        _isvehNeedBtn.layer.borderWidth = 1;
//        [_isvehNeedBtn  setTitle:@"请选择" forState:UIControlStateNormal];
//        _isvehNeedBtn.layer.borderColor = UIColorWithFloat(239).CGColor;
//        _isvehNeedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_isvehNeedBtn  setTitleColor:UIColorWithFloat(108) forState:UIControlStateNormal];
//        [_isvehNeedBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
//        [_isvehNeedBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        _isvehNeedBtn.tag = 3;
//    }
//    return _isvehNeedBtn;
//}

- (UIView *)lineEight{
    if (_lineEight == nil) {
        _lineEight = [[UIView alloc] init];
        _lineEight.backgroundColor = UIColorWithFloat(239);
    }
    return _lineEight;
}




@end
