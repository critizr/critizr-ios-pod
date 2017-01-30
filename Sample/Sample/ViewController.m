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

    CRFeedbackDialog *feedbackDialog = [CRFeedbackDialog feedbackDialog];
    [feedbackDialog presentFeedbackDialogFrom:self];
}

@end
