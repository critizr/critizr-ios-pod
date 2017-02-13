//
//  CRFeedbackDialogViewController.m
//  Critizr
//
//  Created by Ludovic Loridan on 2/26/15.
//  Copyright (c) 2015 Critizr. All rights reserved.
//

#import "CRFeedbackDialogViewController.h"

#import "CRSdk.h"

@interface CRFeedbackDialogViewController ()

@property (strong) UIWebView * webView;

@end

@implementation CRFeedbackDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1]];
    
    self.webView = [[UIWebView alloc] initWithFrame:[self webViewFrame]];
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[self urlToLoad]];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURL *) urlToLoad {
    CRSdk *crSdk = [CRSdk sharedInstance];
    if (self.storeId == nil) {
        NSURL *url = [crSdk urlForStoreLocatorRessource];
        return url;
    } else {
        NSURL *url = [crSdk urlForWidgetRessourceForStroreId:self.storeId withApiKey:crSdk.getApiKey];
        return url;
    }
}

- (CGRect) webViewFrame {
    CGRect frame = self.view.frame;
    if ([self respondsToSelector:@selector(topLayoutGuide)]) { //ios 7 and more
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        frame.origin.y = statusBarHeight;
        frame.size.height = frame.size.height - statusBarHeight;
    }
    return frame;
}

#pragma mark - Events
- (void) dismissForm {
    [self dismissViewControllerAnimated:YES completion:^(void) {
        if ([self.delegate respondsToSelector:@selector(feedbackDialogDidCloseWithMessageSent:)]){
            [self.delegate feedbackDialogDidCloseWithMessageSent:NO];
        }
    }];
}

- (void) dismissFormAndNotifyMessageSent {
    [self dismissViewControllerAnimated:YES completion:^(void) {
        if ([self.delegate respondsToSelector:@selector(feedbackDialogDidCloseWithMessageSent:)]){
            [self.delegate feedbackDialogDidCloseWithMessageSent:YES];
        }
    }];
}

#pragma mark - Status Bar matching the header of dialog

- (UIColor *) colorFromRGBAString: (NSString *) rgbString {
    
    rgbString = [rgbString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"rgba()"]];
    NSArray *rgbArray = [rgbString componentsSeparatedByString:@","];
    
    CGFloat alpha = 1.0;
    if (rgbArray.count > 3) {
        alpha = [[rgbArray objectAtIndex:3] floatValue];
    }
        
    return [[UIColor alloc] initWithRed:(CGFloat) [[rgbArray objectAtIndex:0] floatValue] / 255.0
                                  green:(CGFloat) [[rgbArray objectAtIndex:1] floatValue] / 255.0
                                   blue:(CGFloat) [[rgbArray objectAtIndex:2] floatValue] / 255.0
                                  alpha:alpha];

}

- (void) updateStatusBarBackgroundColor {
    NSString *rgbBackgroundString = [self.webView stringByEvaluatingJavaScriptFromString:@"Critizr.Theme.main_color"];
    if ([rgbBackgroundString length] > 0) {
        UIColor *statusBarBackground = [self colorFromRGBAString:rgbBackgroundString];

        [UIView animateWithDuration:0.25 animations:^(void) {
            self.view.backgroundColor = statusBarBackground;
        }];
    }
}

- (void) updateStatusBarTextColor {
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    NSString *rgbTextString = [self.webView stringByEvaluatingJavaScriptFromString:@"Critizr.Theme.text_color"];
    if ([rgbTextString length] > 0) {
        UIColor *statusBarTextColor = [self colorFromRGBAString:rgbTextString];
        CGFloat white = 0;
        [statusBarTextColor getWhite:&white alpha:nil];
        
        if (white > 0.9) {
            return UIStatusBarStyleLightContent;
        }
    }
    return UIStatusBarStyleDefault;
}

#pragma mark - UI Web View Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[request.URL absoluteString] hasSuffix:@"/exit/"]) {
        [self dismissForm];
        return NO;
    } else if ([[request.URL absoluteString] hasSuffix:@"/success/"]){
        [self dismissFormAndNotifyMessageSent];
        return NO;
    } else {
        return YES;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur de chargement" message:@"Merci de vérifier que vous êtes bien connecté à Internet, puis réessayez." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [self updateStatusBarBackgroundColor];
    [self updateStatusBarTextColor];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissForm];
}



@end
