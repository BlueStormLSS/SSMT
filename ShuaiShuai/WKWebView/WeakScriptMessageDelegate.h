//
//  WeakScriptMessageDelegate.h
//  O2oApp
//
//  Created by 哀木涕 on 2017/7/6.
//  Copyright © 2017年  Vcredit.com. All rights reserved.
//

///为了处理JS调用OC方法后导致的内存不能释放的问题，故用一个代理进行

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic,weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
