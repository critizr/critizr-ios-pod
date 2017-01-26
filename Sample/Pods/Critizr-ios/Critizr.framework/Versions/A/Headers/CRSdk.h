//
//  CRSdk.h
//  Critizr
//
//  Created by Thibaut Carlier on 07/07/2015.
//  Copyright (c) 2015 Critizr. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CRSdkDelegate <NSObject>
@optional
- (void)critizrPlaceRatingFetched:(double)aPlaceRating;
- (void)critizrPlaceRatingError:(NSError *)anError;
@end

@interface CRSdk : NSObject {
    
}
@property (weak)  id<CRSdkDelegate> delegate;

+ (CRSdk *)sharedInstance;
+ (CRSdk *)critizrSDKInstanceWithAPIKey:(NSString *)anApiKey andDelegate:(id<CRSdkDelegate>)delegate;

- (void)fetchRatingForPlace:(NSString *)aPlaceId withDelegate:(id<CRSdkDelegate>)aDelegate;

- (NSURL *)urlForStoreLocatorRessourceWithApiKey:(NSString *)apiKey;

- (NSURL *)urlForWidgetRessourceForStroreId:(NSString *)storeId withApiKey:(NSString *)apiKey;

@end

