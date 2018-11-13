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
#import "GouTongJiLuViewController.h"

@interface B_ViewController ()<UITableViewDelegate,UITableViewDataSource>
// 索引标题数组
@property (nonatomic, strong) NSMutableArray * indexArr;


@property (nonatomic, strong) NSMutableArray * indexArray;

@property (nonatomic, strong) NSMutableArray * fenQuBaohaoArray;

@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableDictionary * dictionAAA;


@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@property(nonatomic,strong)GouTongJiLuViewController *gtjlVC;

@end

@implementation B_ViewController
//按钮点击事件
-(void)segmentValueChanged:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            //            [self.tableview reloadData];
            
            [self.gtjlVC.view removeFromSuperview];
            [self.gtjlVC removeFromParentViewController];
            break;
        case 1:
            //            [self.tableview reloadData];
            
            [self addChildViewController:self.gtjlVC];
            [self.view addSubview:self.gtjlVC.view];
            
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"";
    
    self.gtjlVC = [[GouTongJiLuViewController alloc]init];

    
    NSArray * _titles = @[@"联系人", @"沟通记录"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:_titles];
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor whiteColor];
    [_segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.frame = CGRectMake(0.0, 0.0, 200.0, 29.0);
    self.navigationItem.titleView = _segmentedControl;
    
    
    
    
    
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
    
    [self loddata];
}

- (void)loddata{
    self.dataArray = [@[@"阿虎",@"吕大",@"养虎",@"路飞",@"小天",@"奇人",@"魅力",@"牛逼",@"陈二狗",@"杨过",@"小龙女",@"郭靖",@"黄蓉",@"郭襄",@"乔峰",@"张无忌",@"张三丰",@"周芷若",@"赵敏",@"刘邦",@"狼图腾"]mutableCopy];
    NSMutableArray *pinyinarr = [NSMutableArray arrayWithCapacity:1];
    for (NSString *str in self.dataArray) {
        NSString *string = [self transformPinyinWithchinese:str];
        [pinyinarr addObject:string];
    }
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:1];
    for (NSString *str in _indexArr) {
        int i = 0;
        NSMutableArray *arrr = [NSMutableArray arrayWithCapacity:1];
        for (NSString *str1 in pinyinarr) {
            NSString *str2 = [str1 substringToIndex:1];
            //NSLog(@"%@------%@",str,st);
            if ([str2 isEqualToString:str]) {
                [arrr addObject:self.dataArray[i]];
                [dic setValue:arrr forKey:str];
                [self.fenQuBaohaoArray addObject:dic];
            }
            i++;
        }
    }
    self.dictionAAA = self.fenQuBaohaoArray.firstObject;
    for (NSString *str in [self.dictionAAA objectForKey:@"L"]) {
        NSLog(@"------%@",str);
    }
    
    self.indexArray = (NSMutableArray *)[[self.dictionAAA allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    [self.tableview reloadData];
    
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
    B_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.nameLable.text = [[self.dictionAAA objectForKey:self.indexArray[indexPath.section]] objectAtIndex:indexPath.row];
    cell.phoneNumberLable.text = @"总设计师/架构师";
    
    return cell;
}


//设置标签数(其实就是分区数目):
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexArray.count;
}
//显示每组标题索引 (如果不实现 就不显示右侧索引):
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
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
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    NSInteger count = 0;
//    for(NSString *character in _toBeReturned) {
//        if([character isEqualToString:title]) {
//            return count;
//        }
//        count ++;
//    }
//    return 0;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TXLDetailsViewController *txl = [[TXLDetailsViewController alloc]init];
    txl.title = @"详情信息";
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
