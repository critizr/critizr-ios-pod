//
//  CRSdk.h
//  Critizr
//
//  Created by Thibaut Carlier on 07/07/2015.
//  Copyright (c) 2015 Critizr. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ENV_DEV  1
#define ENV_PREPROD  2
#define ENV_PROD  3

#define ENV ENV_PREPROD


#if ENV == ENV_DEV
    #define BASEURL @"http://dev.critizr.com/"
#elif ENV == ENV_PREPROD
    #define BASEURL @"http://preprod.critizr.com/"
#else
    #define BASEURL @"http://critizr.com/"
#endif

#define PLACE_RESSOURCE_URL BASEURL "widgets/api/%@/place/%@/?only_rating=1"
#define STORE_LOCATOR_RESSOURCE_URL BASEURL "store_locator/%@/sdk/"
#define WIDGET_RESSOURCE_URL BASEURL "widgets/%@/sdk/%@/"




@protocol CRSdkDelegate <NSObject>
@optional
-(void)critizrPlaceRatingFetched:(double)aPlaceRating;
-(void) critizrPlaceRatingError:(NSError *)anError;
@end

@interface CRSdk : NSObject {
    
}
@property (weak)  id<CRSdkDelegate> delegate;

+(CRSdk *)sharedInstance;
+ (CRSdk *)critizrSDKInstanceWithAPIKey:(NSString *)anApiKey andDelegate:(id<CRSdkDelegate>)delegate;

-(void) fetchRatingForPlace:(NSString *)aPlaceId withDelegate:(id<CRSdkDelegate>)aDelegate;


@end

