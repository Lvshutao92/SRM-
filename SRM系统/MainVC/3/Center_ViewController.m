//
//  Center_ViewController.m
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/7.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import "Center_ViewController.h"
#import "XianSuoViewController.h"
#import "JiHuiViewController.h"
#import "UserViewController.h"
#import "HeTongViewController.h"
#import "ShouKuanViewController.h"

@interface Center_ViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate>
{
    UIView *viewBar;
    UIButton *userBtn;
    UISearchBar *_customSearchBar;
    UIScrollView *scrollview;
}


@end

@implementation Center_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"";
    [self setNavigationBar];
    
    [self setupscrollview];
}


- (void)setupscrollview{
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7+130, SCREEN_WIDTH, SCREEN_HEIGHT-200)];
    [self.view addSubview:scrollview];
    
    [self setupscrollviewBtn];
}
- (void)clickAddBtn{
    
    
}
- (void)setupscrollviewBtn{
    NSMutableArray *arr1 = [@[@"线索管理",@"机会管理",@"合同管理",@"收款管理"]mutableCopy];
    NSMutableArray *arr2 = [@[@"xs",@"jh",@"ht",@"sk"]mutableCopy];
    int b = 0;
    int hangshu;
    if (arr1.count % 4 == 0 ) {
        hangshu = (int )arr1.count / 4;
    } else {
        hangshu = (int )arr1.count / 4 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 4; j++) {
            CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
            if ( b  < arr1.count) {
                btn.frame = CGRectMake((0  + j * SCREEN_WIDTH/4), (i * 120) ,SCREEN_WIDTH/4, 120);
                btn.tag = b;
                [btn setTitle:arr1[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.titleLabel.font = FONT(14);
                UIImage *image = [UIImage imageNamed:arr2[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickSYtopBtn:) forControlEvents:UIControlEventTouchUpInside];
                //                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                //                [btn.layer setBorderWidth:0.5f];
                //                [btn.layer setMasksToBounds:YES];
                
                scrollview.contentSize = CGSizeMake(0, (i+1)*120);
                [scrollview addSubview:btn];
                if (b > arr1.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}


- (void)clickSYtopBtn:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"线索管理"]) {
        XianSuoViewController *xiaosuo = [[XianSuoViewController alloc]init];
        MainNavigationViewController *na = [[MainNavigationViewController alloc]initWithRootViewController:xiaosuo];
        na.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:na animated:YES completion:nil];
    }else if ([sender.titleLabel.text isEqualToString:@"机会管理"]) {
        JiHuiViewController *xiaosuo = [[JiHuiViewController alloc]init];
        MainNavigationViewController *na = [[MainNavigationViewController alloc]initWithRootViewController:xiaosuo];
        na.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:na animated:YES completion:nil];
    }else if ([sender.titleLabel.text isEqualToString:@"合同管理"]) {
        HeTongViewController *xiaosuo = [[HeTongViewController alloc]init];
        xiaosuo.title = @"合同管理";
        MainNavigationViewController *na = [[MainNavigationViewController alloc]initWithRootViewController:xiaosuo];
        na.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:na animated:YES completion:nil];
    }else if ([sender.titleLabel.text isEqualToString:@"收款管理"]) {
        ShouKuanViewController *xiaosuo = [[ShouKuanViewController alloc]init];
        MainNavigationViewController *na = [[MainNavigationViewController alloc]initWithRootViewController:xiaosuo];
        na.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:na animated:YES completion:nil];
    }
}





#pragma mark - 设置自定义的导航
- (void)setNavigationBar{
    viewBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavBarHAbove7+130)];
    viewBar.backgroundColor = RGBACOLOR(30, 144, 255, 1);
    [self.view addSubview:viewBar];
    
    CAGradientLayer *_gradientLayer = [CAGradientLayer layer];
    _gradientLayer.bounds = viewBar.bounds;
    _gradientLayer.borderWidth = 0;
    _gradientLayer.frame = viewBar.bounds;
    _gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)RGBACOLOR(135, 206, 250, 1.0).CGColor,
                             (id)RGBACOLOR(30, 144, 255, 1.0).CGColor, nil ,nil];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint   = CGPointMake(1.0, 1.0);
    [viewBar.layer insertSublayer:_gradientLayer atIndex:0];
    
    
    
    
    _customSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, kStatusBarHeight, SCREEN_WIDTH-120, 44)];
    _customSearchBar.delegate = self;
    for (UIView *subview in _customSearchBar.subviews) {
        for(UIView* grandSonView in subview.subviews){
            if ([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                grandSonView.alpha = 0.0f;
            }else if([grandSonView isKindOfClass:NSClassFromString(@"UISearchBarTextField")] ){
                //NSLog(@"Keep textfiedld bkg color");
            }else{
                grandSonView.alpha = 0.0f;
            }
        }
    }
    
    UITextField *searchField = [_customSearchBar valueForKey:@"searchField"];
    searchField.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    if (searchField) {
        LRViewBorderRadius(searchField, 19, 0, [UIColor clearColor]);
    }
    LRViewBorderRadius(_customSearchBar, 22, 0, [UIColor clearColor]);
    _customSearchBar.placeholder = @"";
    [viewBar addSubview:_customSearchBar];
    
    
    userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userBtn.frame = CGRectMake(15, kStatusBarHeight+10, 30, 30);
    LRViewBorderRadius(userBtn, 15, 0, [UIColor clearColor]);
    [userBtn setImage:[UIImage imageNamed:@"tx"] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(clickUserBtn) forControlEvents:UIControlEventTouchUpInside];
    [viewBar addSubview:userBtn];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCREEN_WIDTH-45, kStatusBarHeight+10, 30, 30);
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [viewBar addSubview:addBtn];
    [self setupbtn];
}

- (void)clickUserBtn{
    UserViewController *xiaosuo = [[UserViewController alloc]init];
    xiaosuo.title = @"个人中心";
    MainNavigationViewController *na = [[MainNavigationViewController alloc]initWithRootViewController:xiaosuo];
    na.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:na animated:YES completion:nil];
}





- (void)setupbtn{
    UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(20, kNavBarHAbove7+20, SCREEN_WIDTH-40, 100)];
    bgv.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [viewBar addSubview:bgv];
    
    
    NSMutableArray *arr1 = [@[@"录线索",@"写跟进",@"建任务",@"录订单",@"写日志"]mutableCopy];
    NSMutableArray *arr2 = [@[@"sy1",@"sy2",@"sy3",@"sy1",@"sy5"]mutableCopy];
    int b = 0;
    int hangshu;
    if (arr1.count % 5 == 0 ) {
        hangshu = (int )arr1.count / 5;
    } else {
        hangshu = (int )arr1.count / 5 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 5; j++) {
            CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
            if ( b  < arr1.count) {
                btn.frame = CGRectMake((0  + j * (SCREEN_WIDTH-40)/5), (i * 90) ,(SCREEN_WIDTH-40)/5, 90);
                btn.tag = b;
                [btn setTitle:arr1[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.titleLabel.font = FONT(16);
                UIImage *image = [UIImage imageNamed:arr2[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(clickSYtopBtn:) forControlEvents:UIControlEventTouchUpInside];
                //                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                //                [btn.layer setBorderWidth:0.5f];
                //                [btn.layer setMasksToBounds:YES];
                [bgv addSubview:btn];
                if (b > arr1.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}









//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//
//}

@end
