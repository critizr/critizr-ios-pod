//
//  CRFeedbackDialog.m
//  Critizr
//
//  Created by Ludovic Loridan on 2/25/15.
//  Copyright (c) 2015 Critizr. All rights reserved.
//

#import "CRFeedbackDialog.h"
#import "CRFeedbackDialogViewController.h"

@interface CRFeedbackDialog ()

@property (readwrite, copy) NSString *APIKey;

@end

@implementation CRFeedbackDialog

+ (CRFeedbackDialog *) feedbackDialog {
    
    CRFeedbackDialog *dialog = [[CRFeedbackDialog alloc] init];
    // SETTING UP API KEY
    NSString *czApiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CritizrAPIKey"];
    if (czApiKey == nil){
        NSLog(@"CritizrAPIKey has to be set.");
        [NSException raise:@"CritizrAPIKey has to be set." format:@"CritizrAPIKey should contain your APIKey"];
    }
    dialog.APIKey = czApiKey;
    return dialog;
}

- (void) presentFeedbackDialogFrom:(UIViewController *) viewController {
    CRFeedbackDialogViewController *dialogVC = [[CRFeedbackDialogViewController alloc] init];
    
    if ([viewController conformsToProtocol:@protocol(CRFeedbackDialogDelegate)]) {
        dialogVC.delegate = (id<CRFeedbackDialogDelegate>) viewController;
    }
    dialogVC.APIKey = self.APIKey;
    
    [viewController presentViewController:dialogVC animated:YES completion:nil];
}

- (void) presentFeedbackDialogFrom:(UIViewController *) viewController withStoreIdString:(NSString *)storeId{
    CRFeedbackDialogViewController *dialogVC = [[CRFeedbackDialogViewController alloc] init];
    
    if ([viewController conformsToProtocol:@protocol(CRFeedbackDialogDelegate)]) {
        dialogVC.delegate = (id<CRFeedbackDialogDelegate>) viewController;
    }
    dialogVC.APIKey = self.APIKey;
    dialogVC.storeId = storeId;
    
    [viewController presentViewController:dialogVC animated:YES completion:nil];
}

- (void) presentFeedbackDialogFrom:(UIViewController *) viewController withStoreId:(int)storeId {
    [self presentFeedbackDialogFrom:viewController withStoreIdString:[NSString stringWithFormat:@"%d", storeId]];
}
@end
