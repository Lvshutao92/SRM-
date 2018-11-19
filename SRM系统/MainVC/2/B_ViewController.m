//
//  B_ViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/7.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "B_ViewController.h"
#import "B_TableViewCell.h"
#import "TXLDetailsViewController.h"

@interface B_ViewController ()<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>
{
    NSInteger number;
    NSInteger page;
    MBProgressHUD *_hud;
}
// 索引标题数组
@property (nonatomic, strong) NSMutableArray * indexArr;


@property (nonatomic, strong) NSMutableArray * indexArray;

@property (nonatomic, strong) NSMutableArray * fenQuBaohaoArray;

@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableDictionary * dictionAAA;



@end

@implementation B_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"通讯录";
    
    self.indexArray = [NSMutableArray arrayWithCapacity:1];
    self.dictionAAA = [NSMutableDictionary dictionaryWithCapacity:1];
    // 设置右侧索引数组
    _indexArr = [[NSMutableArray alloc]init];
    [_indexArr addObject:[NSString stringWithFormat:@"#"]];
    for(char c = 'A'; c<='Z'; c++) {
        [_indexArr addObject:[NSString stringWithFormat:@"%c", c]];
    }
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[B_TableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    //设置右侧索引字体颜色:
    self.tableview.sectionIndexColor = [UIColor grayColor];
    //设置右侧索引背景色:
    //self.tableview.sectionIndexBackgroundColor = [UIColor whiteColor];
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    [self setUpRefresh];
//    [self loddata1];
    
}
- (void)setUpRefresh{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
}

- (void)loddeList{
   
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{@"currentPage":@"1",
                          @"pageSize":@"10000",
                          @"sort":@"ContactsPerson_id desc",
                          };
    [Manager requestPOSTWithURLStr:[Manager dictionToString:dic string:KURLNSString(@"contacts/person/list?")] finish:^(id  _Nonnull responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
//        NSLog(@"-444/44------------%@",diction);
        
        
        [weakSelf.dictionAAA removeAllObjects];
        [weakSelf.fenQuBaohaoArray removeAllObjects];
        
        NSMutableArray *dataarr = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *namearr = [NSMutableArray arrayWithCapacity:1];
        [dataarr removeAllObjects];
        [namearr removeAllObjects];
        for (NSDictionary *dt in [diction objectForKey:@"list"]) {
            Model *model = [Model mj_objectWithKeyValues:dt];
            [dataarr addObject:model];
            [namearr addObject:model.personName];
            //NSLog(@"------------%@",model.personName);
        }
        
        NSMutableArray *pinyinarr = [NSMutableArray arrayWithCapacity:1];
        for (NSString *str in namearr) {
            NSString *string = [weakSelf transformPinyinWithchinese:str];
            //NSLog(@"----------------%@",string);
            [pinyinarr addObject:string];
        }
        
        NSMutableArray *arrrrrrr = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *arrrrrrr1 = [NSMutableArray arrayWithCapacity:1];
//        NSMutableDictionary *dt=[NSMutableDictionary dictionaryWithCapacity:1];
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:1];
        for (NSString *str in self->_indexArr) {
            int i = 0;
            NSMutableArray *arrr = [NSMutableArray arrayWithCapacity:1];
            for (NSString *str1 in pinyinarr) {
                NSString *str2 = [str1 substringToIndex:1];
                //NSLog(@"%@**************---%@",str,str2);
                
                
                if (![self->_indexArr containsObject:str2]) {
                    //Model *model = dataarr[i];
                    //NSLog(@"%@----%@",model.personName,str2);
                    if (![arrrrrrr1 containsObject:dataarr[i]]) {
                        [arrrrrrr1 addObject:dataarr[i]];
                        [dic setValue:arrrrrrr1 forKey:@"#"];
                        [arrrrrrr addObject:dic];
                    }
                }else{
                    if ([str2 isEqualToString:str]) {
                        [arrr addObject:dataarr[i]];
                        [dic setValue:arrr forKey:str];
                        [weakSelf.fenQuBaohaoArray addObject:dic];
                    }
                }
                
                
                

                i++;
            }
        }
        
//        for (Model *dic in arrrrrrr) {
//            NSLog(@"**********--------%@",dic);
//        }
        
        weakSelf.dictionAAA = self.fenQuBaohaoArray.firstObject;
//        NSLog(@"===============***************------%@",self.dictionAAA);
        weakSelf.indexArray = (NSMutableArray *)[[weakSelf.dictionAAA allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2]; //升序
        }];
        [self->_hud hideAnimated:YES];
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf.tableview reloadData];
    } enError:^(NSError * _Nonnull error) {
        NSLog(@"error=========%@",error);
        [self->_hud hideAnimated:YES];
        [weakSelf.tableview.mj_header endRefreshing];
    }];
    
}







- (NSString *)transformPinyinWithchinese:(NSString *)chinese {
    NSMutableString *pinyin = [[NSMutableString alloc] initWithString:chinese];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL,      kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL,  kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dictionAAA objectForKey:[self.indexArray objectAtIndex:section]]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    B_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[B_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    Model *model= [[self.dictionAAA objectForKey:self.indexArray[indexPath.section]] objectAtIndex:indexPath.row];
    cell.nameLable.text = model.personName;
    if ([Manager judgeWhetherIsEmptyAnyObject:model.position]!=YES) {
        cell.phoneNumberLable.text = @"暂无";
    }else{
        cell.phoneNumberLable.text = model.position;
    }
    
    
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)clickbtn1:(UIButton *)sender{
    B_TableViewCell *cell = (B_TableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    Model *model= [[self.dictionAAA objectForKey:self.indexArray[indexPath.section]] objectAtIndex:indexPath.row];
    
    NSMutableString *str =[[NSMutableString alloc]initWithFormat:@"tel:%@",model.mobile];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)clickbtn2:(UIButton *)sender{
    B_TableViewCell *cell = (B_TableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    Model *model= [[self.dictionAAA objectForKey:self.indexArray[indexPath.section]] objectAtIndex:indexPath.row];
    
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
    // 设置短信内容
    //vc.body = @"我想法这样的话  http://www.jianshu.com/p/0bac60cb6f38";
    // 设置收件人列表
    vc.recipients = @[model.mobile];  // 号码数组
    // 设置代理
    vc.messageComposeDelegate = self;
    // 显示控制器
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if(result == MessageComposeResultCancelled) {
        //NSLog(@"取消发送");
    } else if(result == MessageComposeResultSent) {
        //NSLog(@"已经发出");
        [self dengdaiupdate:@"发送成功"];
    } else {
         [self dengdaiupdate:@"发送失败"];
        //NSLog(@"发送失败");
    }
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




//设置标签数(其实就是分区数目):
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexArray.count;
}

//设置索引section的高度:
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
//返回每个索引的内容:
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.indexArray[section];
}

//响应点击索引时的委托方法(点击右侧索引表项时调用):
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}
//显示每组标题索引 (如果不实现 就不显示右侧索引):
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
}









- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Model *model= [[self.dictionAAA objectForKey:self.indexArray[indexPath.section]] objectAtIndex:indexPath.row];
    
    TXLDetailsViewController *txl = [[TXLDetailsViewController alloc]init];
    txl.title = @"详情信息";
    txl.model = model;
    [self.navigationController pushViewController:txl animated:YES];
}






- (NSMutableArray *)fenQuBaohaoArray{
    if (_fenQuBaohaoArray == nil) {
        self.fenQuBaohaoArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _fenQuBaohaoArray;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
