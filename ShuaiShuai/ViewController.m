//
//  ViewController.m
//  ShuaiShuai
//
//  Created by 哀木涕 on 2017/7/6.
//  Copyright © 2017年 哀木涕. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@property (nonatomic,strong) NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataArr[indexPath.row][0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[NSClassFromString(_dataArr[indexPath.row][1]) alloc] init];
    vc.title = _dataArr[indexPath.row][0];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@[@"WKWebView",@"WKWebViewVC"],@[@"绘制图形",@"DrawVC"]];
    }
    return _dataArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
