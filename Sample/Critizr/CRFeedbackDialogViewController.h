//
//  CRFeedbackDialogViewController.h
//  Critizr
//
//  Created by Ludovic Loridan on 2/26/15.
//  Copyright (c) 2015 Critizr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRFeedbackDialog.h"


@interface CRFeedbackDialogViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>

@property (weak) id<CRFeedbackDialogDelegate> delegate;

@property (copy) NSString *APIKey;
@property (copy) NSString *storeId;

@end
