//
//  WKWebViewVC.m
//  ShuaiShuai
//
//  Created by 哀木涕 on 2017/7/6.
//  Copyright © 2017年 哀木涕. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>

#import "WeakScriptMessageDelegate.h"

@interface WKWebViewVC ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
}
- (WKWebView *)webView{
    if (!_webView) {
        ///JS调用OC方法
        ///与JS交互
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        ///JS调用OC
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"popAlertPanel"];
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"popConfirmPanel"];
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"popTextInputPanel"];
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"NativeMethod"];
        
        
        configuration.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WKWebView" ofType:@"html"];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
        
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
        [_webView loadRequest:request];
    }
    return _webView;
}
#pragma mark - WKUIDelegate主要是做跟网页交互的，可以显示javascript的一些alert或者Action，看起来跟自己做的一样的 -

//1.创建一个新的WebVeiw
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//
//}

//2.WebVeiw关闭（9.0中的新方法）
//- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);

//3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    [self alertMessage:message sure:^{
        completionHandler();
    }];
    
}
//4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    [self alertMessage:prompt placeholder:defaultText text:^(NSString *str) {
        completionHandler(str);
    }];
}
//5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    [self alertMessage:message sure:^{
        completionHandler(YES);
    } cancle:^{
        completionHandler(NO);
    }];
}



#pragma mark - WKNavigationDelegate来追踪加载过程 -
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
#pragma mark - WKNavigtionDelegate来进行页面跳转 -
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}





///window.webkit.messageHandlers.<name>.postMessage(<messageBody>)
//其中<name>，就是上面方法里的第二个参数`name`。
//例如我们调用API的时候第二个参数填@"Share"，那么在JS里就是:
//window.webkit.messageHandlers.Share.postMessage(<messageBody>)
//messageBody是一个键值对，键是body，值可以有多种类型的参数。
// 在`WKScriptMessageHandler`协议中，我们可以看到mssage是`WKScriptMessage`类型，有一个属性叫body。
// 而注释里写明了body 的类型：
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
}


- (void)dealloc{
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"NativeMethod"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"popAlertPanel"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"popConfirmPanel"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"popTextInputPanel"];
    
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
