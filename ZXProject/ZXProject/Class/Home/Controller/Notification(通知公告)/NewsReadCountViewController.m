//
//  NewsReadCountViewController.m
//  ZXProject
//
//  Created by Me on 2018/5/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "NewsReadCountViewController.h"
#import "HttpClient.h"
#import "NotificationModel.h"
#import "GobHeaderFile.h"
#import "NewsReadListCell.h"

@interface NewsReadCountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *readList;
@property (nonatomic, strong) UITableView *listView;

@end

@implementation NewsReadCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"阅读详情";
    [self setNetworkRequest];
    [self initSubViews];
}

- (void)setNetworkRequest{
    ZXSHOW_LOADING(self.view, @"记载中");
    [HttpClient zx_httpClientToGetNoticeReaderlistWithNoticeid:[self.model.noticeid longLongValue] andSuccessBlock:^(int code, id  _Nullable data, NSString * _Nullable message, NSError * _Nullable error) {
        ZXHIDE_LOADING;
        if (code == 0) {
            self.readList = data[@"noticereaderlist"];
            [self.listView reloadData];
        }else{
            [MBProgressHUD showError:message toView:self.view];
        }
    }];
}

- (void)initSubViews{
    [self.view addSubview:self.listView];
    self.listView.frame = self.view.bounds;
}

#pragma UITableViewDelegate && DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.readList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NewsReadListCell *cell = [NewsReadListCell newsReadListCellWithTableView:tableView];
        return cell;
    }
    NewsReadListCell *cell = [NewsReadListCell newsReadListCellWithTableView:tableView];
    cell.model = self.readList[indexPath.row - 1];
    cell.index = (int)(indexPath.row + 1);
    return cell;
}


#pragma mark - setter && getter

- (UITableView *)listView{
    if (_listView == nil) {
        _listView = [[UITableView alloc] init];
        _listView.backgroundColor = [UIColor whiteColor];
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _listView;
}


@end
