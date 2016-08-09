//
//  ViewController.m
//  Sample
//
//  Created by Jean-Philippe DESCAMPS on 09/08/2016.
//  Copyright © 2016 Critizr. All rights reserved.
//

#import "ViewController.h"
#import <Critizr/Critizr.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *apiKey = @"3f672def9b5902a4eb4ab5c936bc7b0d";
    
    CRFeedbackDialog *feedbackDialog = [CRFeedbackDialog feedbackDialogWithAPIKey:apiKey];
    [feedbackDialog presentFeedbackDialogFrom:self];
}

@end
