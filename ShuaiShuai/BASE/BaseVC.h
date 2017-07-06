//
//  BaseVC.h
//  ShuaiShuai
//
//  Created by 哀木涕 on 2017/7/6.
//  Copyright © 2017年 哀木涕. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseVC : UIViewController

///提示框
- (void)alertMessage:(NSString *)message sure:(void (^)(void))actions;// action:(NSArray *)actionArr sureAction:(void (^)(void))sure;
///确认框
- (void)alertMessage:(NSString *)message sure:(void (^)(void))sure cancle:(void (^)(void))cancle;
///输入框
- (void)alertMessage:(NSString *)message placeholder:(NSString *)placeholder text:(void (^)(NSString *str))text ;

@end
