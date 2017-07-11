//
//  DrawVC.m
//  ShuaiShuai
//
//  Created by 哀木涕 on 2017/7/11.
//  Copyright © 2017年 哀木涕. All rights reserved.
//

#import "DrawVC.h"
#import "DrawView.h"
@interface DrawVC ()

@property (nonatomic,strong) DrawView *drawView;

@end

@implementation DrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[[DrawView alloc] initWithFrame:self.view.bounds]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
