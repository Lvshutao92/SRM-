//
//  GouTongViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/19.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "GouTongViewController.h"
#import "GTJL_Cell.h"
@interface GouTongViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *bgview;
    
    UIImageView *topview;
    CGFloat height;
    
    
}


@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation GouTongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"GTJL_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    [self.view addSubview:self.tableview];
    
    self.tableview.tableHeaderView = bgview;
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = footer;
    
    [self loddeList];
}





- (void)loddeList{
    MBProgressHUD *_hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.label.text = NSLocalizedString(@"请稍等...", @"HUD loading title");
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{@"currentPage":@"1",
                          @"pageSize":@"10000",
                          @"sort":@"ContactsCommunicate_communicateTime desc",
                          @"contactsPersonId":self.model.id,
                          };
    //    NSLog(@"-44444------------%@",dic);
    [Manager requestPOSTWithURLStr:[Manager dictionToString:dic string:KURLNSString(@"contacts/communicate/list?")] finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //        NSLog(@"-44444------------%@",diction);
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dict in [diction objectForKey:@"list"]) {
            Model *model = [Model mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        
        [_hud hideAnimated:YES];
        [weakSelf.tableview reloadData];
        
        if (weakSelf.dataArray.count == 0) {
            [weakSelf dengdaiupdate:@"无沟通记录"];
        }
    } enError:^(NSError * _Nonnull error) {
        //        NSLog(@"error=========%@",error);
        [_hud hideAnimated:YES];
    }];
}

- (void)dengdaiupdate:(NSString *)str{
    MBProgressHUD *hud= [[MBProgressHUD alloc] initWithView:self.view];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.label.text =str;
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wu"]];
    [hud setCustomView:imageview];
    [hud setMode:MBProgressHUDModeCustomView];
    [self.view addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.0];
}







- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    GTJL_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[GTJL_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.contentView.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    LRViewBorderRadius(cell.bgview, 10, 0, [UIColor whiteColor]);
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.topview.backgroundColor = RGBACOLOR(64, 64, 64, 1);
    LRViewBorderRadius(cell.btn, 15, 1, [UIColor darkGrayColor]);
    
    
    Model *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = model.contactsPersonName;
    cell.lab2.text = model.communicateType;
    
    
    cell.lab5.numberOfLines = 0;
    CGFloat hei = [Manager heightForString:[NSString stringWithFormat:@"跟进结果：%@",model.communicateResult] fontSize:15 andWidth:SCREEN_WIDTH-40];
    //    NSLog(@"--------------%lf",hei);
    cell.resultHeight.constant = hei;
    height = 330+hei;
    
    cell.lab3.text = [NSString stringWithFormat:@"跟进时间：%@",model.communicateTime];
    
    if (model.communicateStage==nil) {
        cell.lab4.text = [NSString stringWithFormat:@"跟进阶段：无"];
    }else{
        cell.lab4.text = [NSString stringWithFormat:@"跟进阶段：%@",model.communicateStage];
    }
    
    
    
    cell.lab5.text = [NSString stringWithFormat:@"跟进结果：%@",model.communicateResult];
    cell.lab6.text = [NSString stringWithFormat:@"跟进人：%@",model.createPersonName];
    cell.lab7.text = [NSString stringWithFormat:@"录入时间：%@",model.createTime];
    
    if (model.communicateFile==nil) {
        cell.lab8.text = [NSString stringWithFormat:@"附件：无"];
    }else{
        cell.lab8.text = [NSString stringWithFormat:@"附件：%@",model.communicateFile];
    }
    
    
    return cell;
}



























- (NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
