//
//  XianSuoViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/9.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "XianSuoViewController.h"
#import "GongYouXianSuoCell.h"
#import "SiYouViewController.h"
#import "AddGongYouViewController.h"
#import "AddSiYouViewController.h"
#import "AddGongYouConnectViewController.h"
#import "ADD_GouTongJiLu_ViewController.h"

#import "XianSuoDetails_One_ViewController.h"

@interface XianSuoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger number;
    NSInteger page;
}
@property(nonatomic,strong)UISegmentedControl *segmentedControl;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)SiYouViewController *siyouVC;
@end

@implementation XianSuoViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)clickAdd{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        AddGongYouViewController *add = [[AddGongYouViewController alloc]init];
        add.title = @"新增公有线索";
        [self.navigationController pushViewController:add animated:YES];
    }else{
        AddSiYouViewController *add = [[AddSiYouViewController alloc]init];
        add.title = @"新增私有线索";
        [self.navigationController pushViewController:add animated:YES];
    }
}

- (void)clickback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"";
    UIView *btnview = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 7, 30, 30);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btnview addSubview:btn];
    [btn addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btnview];
    self.navigationItem.leftBarButtonItem = bar;
    
    UIBarButtonItem *baradd = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickAdd)];
    self.navigationItem.rightBarButtonItem = baradd;
    
    self.siyouVC = [[SiYouViewController alloc]init];
    
    
    NSArray * _titles = @[@"公有线索", @"私有线索"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:_titles];
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor whiteColor];
    [_segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.frame = CGRectMake(0.0, 0.0, 200.0, 29.0);
    self.navigationItem.titleView = _segmentedControl;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"GongYouXianSuoCell" bundle:nil] forCellReuseIdentifier:@"gongyoucell"];
    [self.view addSubview:self.tableview];
    
    UIView *footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = footerview;

    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    
    
    
    [self setUpRefresh];
}

//按钮点击事件
-(void)segmentValueChanged:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
//            [self.tableview reloadData];
            
            [self.siyouVC.view removeFromSuperview];
            [self.siyouVC removeFromParentViewController];
            break;
        case 1:
//            [self.tableview reloadData];
            
            [self addChildViewController:self.siyouVC];
            [self.view addSubview:self.siyouVC.view];
            
            break;
        default:
            break;
    }
}

- (void)setUpRefresh{
    __weak typeof (self) weakSelf = self;
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    
    
    self.tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (weakSelf.dataArray.count == self->number) {
            [weakSelf.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}
- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{@"currentPage":@"1",
                          @"pageSize":@"10",
                          @"sort":@"LeadPublic_id desc",
                          };
    [Manager requestPOSTWithURLStr:[Manager dictionToString:dic string:KURLNSString(@"lead/public/list?")] finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
       // NSLog(@"-44444------------%@",diction);
        self->number = [[diction objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dt in [diction objectForKey:@"list"]) {
            Model *model = [Model mj_objectWithKeyValues:dt];
            [weakSelf.dataArray addObject:model];
        }
        self->page = 2;
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        [weakSelf.tableview.mj_header endRefreshing];
        NSLog(@"error=========%@",error);
    }];
    
}

- (void)loddeSLList{
    [self.tableview.mj_header endRefreshing];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{@"currentPage":[NSString stringWithFormat:@"%ld",page],
                          @"pageSize":@"10",
                          @"sort":@"LeadPublic_id desc",
                          };
    [Manager requestPOSTWithURLStr:[Manager dictionToString:dic string:KURLNSString(@"lead/public/list?")] finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        for (NSDictionary *dt in [diction objectForKey:@"list"]) {
            Model *model = [Model mj_objectWithKeyValues:dt];
            [weakSelf.dataArray addObject:model];
        }
        self->page ++;
        [weakSelf.tableview.mj_footer endRefreshing];
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
        NSLog(@"error=========%@",error);
    }];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Model *model = [self.dataArray objectAtIndex:indexPath.row];
//    XianSuoDetails_One_ViewController *one = [[XianSuoDetails_One_ViewController alloc]init];
//    [Manager sharedManager].idXianSuoString = model.id;
//    [self.navigationController pushViewController:one animated:YES];
}






#pragma mark tableview-delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 425;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"gongyoucell";
    GongYouXianSuoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[GongYouXianSuoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.contentView.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    LRViewBorderRadius(cell.bgview, 10, 0, [UIColor whiteColor]);
    cell.toplab.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    LRViewBorderRadius(cell.btn1, 15, 1, [UIColor lightGrayColor]);
    [cell.btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    Model *mo = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = mo.customerShortName;
    
    cell.lab2.text = [NSString stringWithFormat:@"行业 %@",mo.customerIndustry];
    cell.lab3.text = [NSString stringWithFormat:@"%@",mo.customerScale];
    cell.lab4.text = [NSString stringWithFormat:@"地址 %@",mo.customerAddress];
    cell.lab5.text = [NSString stringWithFormat:@"%@",mo.createPersonName];
    cell.lab6.text = [NSString stringWithFormat:@"联系人数 %@",mo.contactPersonNum];
    cell.lab7.text = [NSString stringWithFormat:@"沟通次数 %@",mo.contactsCommunicateNum];
    
    cell.lab8.text = [NSString stringWithFormat:@"沟通渠道 %@",mo.leadSource];
    cell.lab9.text = [NSString stringWithFormat:@"线索编号 %@",mo.leadNo];
    cell.lab10.text = [NSString stringWithFormat:@"已创建天数 %@",mo.existDays];
    cell.lab11.text = [NSString stringWithFormat:@"获取日期 %@",mo.leadGetDate];
    [cell.btn1 addTarget:self action:@selector(clickbtn1gy:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 addTarget:self action:@selector(clickbtn3gy:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickbtn1gy:(UIButton *)sender{
    GongYouXianSuoCell *cell = (GongYouXianSuoCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Model *model = [self.dataArray objectAtIndex:indexpath.row];
    AddGongYouViewController *edit = [[AddGongYouViewController alloc]init];
    edit.title = @"编辑公有线索";
    edit.model = model;
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)clickbtn3gy:(UIButton *)sender{
    LRWeakSelf(self);
    GongYouXianSuoCell *cell = (GongYouXianSuoCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    Model *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请选择以下操作" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *aaa = [UIAlertAction actionWithTitle:@"编辑线索" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddGongYouViewController *edit = [[AddGongYouViewController alloc]init];
        edit.title = @"编辑公有线索";
        edit.model = model;
        [weakSelf.navigationController pushViewController:edit animated:YES];
        
    }];
    UIAlertAction *bbb = [UIAlertAction actionWithTitle:@"新增联系人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddGongYouConnectViewController *edit = [[AddGongYouConnectViewController alloc]init];
        edit.title = @"新增联系人";
        edit.model = model;
        [weakSelf.navigationController pushViewController:edit animated:YES];
    }];
    UIAlertAction *ccc = [UIAlertAction actionWithTitle:@"新增沟通记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ADD_GouTongJiLu_ViewController *edit = [[ADD_GouTongJiLu_ViewController alloc]init];
        edit.title = @"新增沟通记录";
        edit.model = model;
        [weakSelf.navigationController pushViewController:edit animated:YES];
    }];
    UIAlertAction *ddd = [UIAlertAction actionWithTitle:@"转入私有线索" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [Manager requestPOSTWithURLStr:[Manager dictionToString:@{@"id":model.id} string:KURLNSString(@"lead/public/toPrivate?")] finish:^(id  _Nonnull responseObject) {
            NSDictionary *diction = [Manager returndictiondata:responseObject];
            //NSLog(@"------------%@",diction);
            if ([[diction objectForKey:@"code"]isEqualToString:@"success"]) {
                [weakSelf dengdaiupdate:@"已转入私有线索"];
                 [weakSelf setUpRefresh];
            }
        } enError:^(NSError * _Nonnull error) {
            
        }];
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:aaa];
    [alert addAction:bbb];
    [alert addAction:ccc];
    [alert addAction:ddd];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)dengdaiupdate:(NSString *)str{
    MBProgressHUD *hud= [[MBProgressHUD alloc] initWithView:self.view];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.text =str;
    [hud setMode:MBProgressHUDModeCustomView];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.0];
}








- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
