//
//  WeakScriptMessageDelegate.m
//  O2oApp
//
//  Created by 哀木涕 on 2017/7/6.
//  Copyright © 2017年  Vcredit.com. All rights reserved.
//



#import "WeakScriptMessageDelegate.h"

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate{
    if (self = [super init]) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
