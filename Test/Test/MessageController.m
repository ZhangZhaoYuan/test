//
//  MessageController.m
//  Test
//
//  Created by xinxin on 2020/4/12.
//  Copyright © 2020 PM. All rights reserved.
//

#import "MessageController.h"
#import "HttpServerce.h"
#import "MessageCell.h"
#import "MessageModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ZYProgressHUD.h"
#define ListUrl @"https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message"
#define UserId @"20200412123600"
#define kWidth [[UIScreen mainScreen] bounds].size.width
@interface MessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger direction;
@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息";
    _direction = 0;
    [self.view addSubview:self.tableView];
    __weak typeof(self) weakObj = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakObj.dataArray removeAllObjects];
        weakObj.direction = 0;
        [weakObj getData];
    }];
    self.tableView.mj_header= header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self->_direction = 1;//1取更新的元素
        [weakObj getData];
    }];
    self.tableView.mj_footer = footer;
   
    [self getData];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"MessageCellId";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    MessageModel *model = self.dataArray[indexPath.row];
    cell.contentLabel.text = model.content;
    return cell;
}
-(void)getData{
    [ZYProgressHUD showLoading:@""];
    NSDictionary *param = @{@"id":UserId,@"limit":@10};
    [[HttpServerce instance]sendHttpGetMethod:ListUrl andParameters:param completion:^(id objects, BOOL isSuccess) {
        [ZYProgressHUD hide];
        if (isSuccess) {
            NSArray *tempArray = objects[@"data"][@"items"];
            for (NSDictionary *dic in tempArray) {
                [self.dataArray addObject:[MessageModel objectWithKeyValues:dic]];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
    }];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView setTableFooterView:[UIView new]];
    }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
