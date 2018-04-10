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
#import "ZXRecordKit.h"
#import "workTaskHeaderView.h"



@interface WorkTaskAddController()<WorkTaskAddImagePickViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,workTaskHeaderViewDelegate>


@property (nonatomic, strong) WorkTaskAddImagePickView *pickView;
@property (nonatomic, strong) workTaskHeaderView *headerView;
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

@property (nonatomic, strong) RecordView *recordView;


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
            [HttpClient zx_httpClientToGetWorkTaskPointProjectoRgregionWithPosition:[UserLocationManager sharedUserLocationManager].position andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
                if (code == 0) {
                    NSDictionary *dict = data[@"projectorgregion"];
                    for (WorkTaskDetailModel *model in self.projectRegions) {
                        if (model.orgid == [dict[@"orgid"] longValue]) {
                            self.currentModel = model;
                            break;
                        }
                    }
                }
                [self setPositionAdress];
            }];
        }
    }];
}

- (void)setPositionAdress{
    if ([UserLocationManager sharedUserLocationManager].positionAdress != nil) {
        self.headerView = [workTaskHeaderView workTaskViewWithImageUrls:nil andPositionAdress:[UserLocationManager sharedUserLocationManager].positionAdress];
        self.headerView.delegate = self;
         [self setSubViews];
    }else{
        [[UserLocationManager sharedUserLocationManager] reverseGeocodeLocationWithAdressBlock:^(NSDictionary *addressDic) {
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            self.headerView = [workTaskHeaderView workTaskViewWithImageUrls:nil andPositionAdress:[NSString stringWithFormat:@"%@%@%@%@",state,city, subLocality, street]];
            self.headerView.delegate = self;
             [self setSubViews];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}

- (void)setSubViews{
    __weak typeof(self) weakself = self;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.dutyRegionLabel];
    [self.view addSubview:self.dutyPersonLabel];
    [self.view addSubview:self.lineFive];
    [self.view addSubview:self.reslovBtn];
    [self.view addSubview:self.reslovPersonLabel];
    [self.view addSubview:self.lineSix];
    [self.view addSubview:self.lineSeven];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.saveBtn];
    [self.reslovPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left).offset(15);
        make.top.equalTo(weakself.headerView.mas_bottom).offset(15);
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
    [self.lineSeven mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.view.mas_left);
        make.right.equalTo(weakself.view.mas_right);
        make.top.equalTo(weakself.dutyPersonLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
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
    UIAlertAction *alterAction_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alterVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [alterAction_0 setTitleColor:UIColorWithFloat(49)];
    [alterAction_2 setTitleColor:UIColorWithRGB(245, 0, 0)];
    [alterVc addAction:alterAction_0];
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
    if (btn.tag == 3) {
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
    }else if (btn.tag == 5){//保存
        
    }else if (btn.tag == 6){//提交
        if (self.currentModel == nil) {
            [MBProgressHUD showError:@"请选择责任人和责任区域" toView:self.view];
        }else{
            
        }
        
    }
   
}

- (void)workTaskHeaderViewDidClickAtionWithTag:(int)tag{
    if (tag == 1006) {//录音
        [self clickVoiceBtn];
    }
}

- (void)clickVoiceBtn{
    UIButton *coverView = [[UIButton alloc] init];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    coverView.frame = self.view.bounds;
    [coverView addTarget:self action:@selector(clickCoverBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:coverView];
    CGFloat width = self.view.width * 0.7;
    RecordView *recordView = [RecordView recordViewWithFrame:CGRectMake((self.view.width - width)*0.5,(self.view.height - 300) * 0.5 , width, 300)];
    self.recordView = recordView;
    [self.view addSubview:recordView];
}

- (void)clickCoverBtn:(UIButton *)btn{
    [btn removeFromSuperview];
    [self.recordView removeFromSuperview];
}

#pragma mark - setter && getter


- (UILabel *)dutyRegionLabel{
    if (_dutyRegionLabel == nil) {
        _dutyRegionLabel = [[UILabel alloc] init];
        _dutyRegionLabel.textColor = UIColorWithFloat(79);
        _dutyRegionLabel.font = [UIFont systemFontOfSize:15];
        if (self.currentModel != nil) {
            _dutyRegionLabel.text = [NSString stringWithFormat:@"责任区:  %@",self.currentModel.orgname];
        }else{
            _dutyRegionLabel.text = @"责任区: ";
        }
    }
    return _dutyRegionLabel;
}

- (UILabel *)dutyPersonLabel{
    if (_dutyPersonLabel == nil) {
        _dutyPersonLabel = [[UILabel alloc] init];
        _dutyPersonLabel.textColor = UIColorWithFloat(79);
        _dutyPersonLabel.font = [UIFont systemFontOfSize:15];
        _dutyPersonLabel.textAlignment = NSTextAlignmentLeft;
        if (self.currentModel != nil) {
            _dutyPersonLabel.text = [NSString stringWithFormat:@"责任人:  %@",self.currentModel.employername];
        }else{
            _dutyPersonLabel.text = @"责任人:  ";
        }
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
