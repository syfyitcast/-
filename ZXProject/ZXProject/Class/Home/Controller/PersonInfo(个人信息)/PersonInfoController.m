//
//  PersonInfoController.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/29.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "PersonInfoController.h"
#import "GobHeaderFile.h"
#import "PersoninfoDeflutCell.h"
#import "ProjectManager.h"
#import "PersonInfoHeaderCell.h"

@interface PersonInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, strong) NSArray *modelDict;


@end

@implementation PersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = UIColorWithFloat(228);
    [self.view addSubview:self.myTable];
    
}

#pragma TableViewDelegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 7;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PersonInfoHeaderCell *cell = [PersonInfoHeaderCell personInfoHeaderCellWithTableView:tableView];
            cell.url = [UserManager sharedUserManager].user.photourl;
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.text = @"二维码";
            cell.textLabel.textColor = UIColorWithFloat(33);
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeIcon"]];
            return cell;
        }
    }else if (indexPath.section == 1){
        PersoninfoDeflutCell *cell = [PersoninfoDeflutCell personinfoDeflutCellWithTableView:tableView];
        cell.mdoelDict = self.modelDict[indexPath.row];
        if (indexPath.row == self.modelDict.count - 1) {
            [cell hideBottomLine];
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 85;
        }else{
            return 50;
        }

    }else if (indexPath.section == 1){
        return 50;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = UIColorWithFloat(228);
        return view;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - setter && getter

- (UITableView *)myTable{
    if (_myTable == nil) {
        _myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 85 + 50 + 10 + 7 * 50) style:UITableViewStylePlain];
        _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTable.backgroundColor = WhiteColor;
        _myTable.bounces = NO;
        _myTable.delegate = self;
        _myTable.dataSource = self;
    }
    return _myTable;
}

- (NSArray *)modelDict{
    if (_modelDict == nil) {
        User *user = [UserManager sharedUserManager].user;
        _modelDict = @[
                       @{
                           @"姓名":user.employername
                        },
                       
                       @{
                           @"性别":[user.gender intValue] == 0?@"男":@"女"
                         
                         }
                       ,
                       @{
                           @"手机号":user.mobileno?user.mobileno:@""
                           
                           }
                       ,
                       @{
                           @"工号":user.workno?user.workno:@""
                           
                           },
                       @{
                           @"所属项目":[ProjectManager sharedProjectManager].currentModel.projectname?[ProjectManager sharedProjectManager].currentModel.projectname:@""
                           
                           },
                       @{
                           @"所属机构":user.companyname?user.companyname:@""
                           
                           },
                       @{
                           @"职务":user.userrank?user.userrank:@""
                           
                           }
                       ];
    }
    return _modelDict;
}

@end
