//
//  ViewController.m
//  KPieChartView
//
//  Created by tenghu on 2017/11/8.
//  Copyright © 2017年 tenghu. All rights reserved.
//

#import "ViewController.h"
#import "XYPieChartView.h"
#import "XYCommon.h"

#define RGB(r,g,b)[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

@interface ViewController ()<PieChartDelegate>

@property (nonatomic, strong)XYPieChartView *pieChartView;
@property (nonatomic, strong)NSMutableArray *pieChartArray;

@property (nonatomic, strong)NSMutableArray *pieChartPercentArray;

@property (nonatomic,strong) NSMutableArray *colorArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createPieChart];
    
}
#pragma mark - 饼状图
- (void)createPieChart{
    
    _pieChartArray = [NSMutableArray arrayWithObjects:@{@"title":@"黑头", @"person":@"10", @"amount":@"10234"}, @{@"title":@"螨虫", @"person":@"26", @"amount":@"9820"} ,@{@"title":@"痘印", @"person":@"21", @"amount":@"1450"} ,@{@"title":@"酒糟鼻", @"person":@"20", @"amount":@"9700"},@{@"title":@"激素脸", @"person":@"20", @"amount":@"9700"},@{@"title":@"过敏脸", @"person":@"20", @"amount":@"9700"},@{@"title":@"痘坑", @"person":@"20", @"amount":@"9700"},@{@"title":@"祛痘", @"person":@"20", @"amount":@"9700"}, nil];
    _pieChartPercentArray = [NSMutableArray arrayWithObjects:@"10.0", @"10", @"10", @"10",@"10",@"10",@"10",@"30", nil];
    
    _colorArray = [NSMutableArray arrayWithObjects: RGB(214, 86, 87),RGB(127, 204, 20),RGB(39, 152, 159),RGB(25, 111, 171),RGB(118, 38, 115),RGB(205, 29, 101),RGB(77, 197, 192),RGB(219, 119, 59),nil];
    
    CGRect pieChartFrame = CGRectMake(0, 0, 160, 160);
    
    
    _pieChartView = [[XYPieChartView alloc] initWithFrame:pieChartFrame withPieChartTypeArray:_pieChartArray withPercentArray:_pieChartPercentArray withColorArray:_colorArray];
    _pieChartView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 180);
    _pieChartView.delegate = self;
    
    // 当有一项数据的百分比小于你所校验的数值时，会将该项数值百分比移出饼图展示（校验数值从0~100）
    [_pieChartView setCheckLessThanPercent:100];
    
    // 刷新加载
    [_pieChartView reloadChart];
    
    NSMutableAttributedString * str = [self compareString:@"￥" andLast:@"2,333,000" withColor:[UIColor yellowColor] withFirstFont:[UIFont systemFontOfSize:10] withLastFont:[UIFont systemFontOfSize:14]];
    [_pieChartView setTitleText:str];
    
    [_pieChartView setAmountText:@"42人"];
    
    [self.view addSubview:_pieChartView];
    
}
- (NSMutableAttributedString *) compareString:(NSString *)firstStr andLast:(NSString *)nextStr withColor:(UIColor *)color withFirstFont:(UIFont *)firstFont withLastFont:(UIFont *)lastFont{
    
    NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:firstStr];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:firstFont,NSForegroundColorAttributeName:color,};
    [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
    NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:nextStr];
    NSDictionary * secondAttributes = @{NSFontAttributeName:lastFont,NSForegroundColorAttributeName:color,};
    [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
    [firstPart appendAttributedString:secondPart];
    return  firstPart;
    
}

#pragma mark - <选中扇形回调>
- (void)selectedFinish:(XYPieChartView *)pieChartView index:(NSInteger)index selectedType:(NSDictionary *)selectedType {
    
    NSLog(@"title%@   人数%@    总值%@%%   index%ld",selectedType[@"title"],selectedType[@"person"],selectedType[@"amount"],(long)index);
    
}

#pragma mark - <点击扇形同心圆回调>
- (void)onCenterClick:(XYPieChartView *)PieChartView {
    
    NSLog(@"点击了圆心");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
