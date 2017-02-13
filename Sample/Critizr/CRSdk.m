//
//  CRSdk.m
//  Critizr
//
//  Created by Thibaut Carlier on 07/07/2015.
//  Copyright (c) 2015 Critizr. All rights reserved.
//

#import "CRSdk.h"

#import "SynthesizeSingleton.h"

#define N_BASEURL_PREPROD @"http://preprod.critizr.com/"
#define N_BASEURL_PROD @"http://critizr.com/"

@interface CRSdk ()

@property (strong) NSMutableData *responseData;

@property (readwrite, copy) NSString *APIKey;
@property (readwrite, copy) NSString *N_BASEURL;

@property (readwrite, copy) NSString *N_PLACE_RESSOURCE_URL;
@property (readwrite, copy) NSString *N_STORE_LOCATOR_RESSOURCE_URL;
@property (readwrite, copy) NSString *N_WIDGET_RESSOURCE_URL;

@end

@implementation CRSdk

@synthesize delegate;
SYNTHESIZE_SINGLETON_FOR_CLASS(CRSdk);

- (id) init
{
    self = [super init];
    if(self)
    {
        // SETTING UP ENVIRONEMENT
        NSString *czEnv = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CritizrEnvironement"];
        if (czEnv == nil){
            NSLog(@"CritizrEnvironement has to be set.");
            [NSException raise:@"CritizrEnvironement has to be set." format:@"CritizrEnvironement should either be Production or PreProduction"];
        }
        if ([czEnv isEqualToString:@"Production"]){
            NSLog(@"ENV: Production");
            self.N_BASEURL = N_BASEURL_PROD;
        } else if ([czEnv isEqualToString:@"PreProduction"]){
            NSLog(@"ENV: PreProduction");
            self.N_BASEURL = N_BASEURL_PREPROD;
        } else {
            NSLog(@"Invalid CritizrEnvironement value");
            [NSException raise:@"Invalid CritizrEnvironement value" format:@"CritizrEnvironement should either be Production or PreProduction"];
        }
        self.N_PLACE_RESSOURCE_URL = [self.N_BASEURL stringByAppendingString:@"widgets/api/%@/place/%@/?only_rating=1"];
        self.N_STORE_LOCATOR_RESSOURCE_URL = [self.N_BASEURL stringByAppendingString:@"store_locator/%@/sdk/"];
        self.N_WIDGET_RESSOURCE_URL = [self.N_BASEURL stringByAppendingString:@"widgets/%@/sdk/%@/"];
        
        // SETTING UP API KEY
        NSString *czApiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CritizrAPIKey"];
        if (czApiKey == nil){
            NSLog(@"CritizrAPIKey has to be set.");
            [NSException raise:@"CritizrAPIKey has to be set." format:@"CritizrAPIKey should contain your APIKey"];
        }
        self.APIKey = czApiKey;
    }
    
    return self;
}

+ (CRSdk *)critizrSDKInstance: key andDelegate:(id<CRSdkDelegate>)delegate
{
    CRSdk *sdk = [CRSdk sharedInstance];
    [sdk setDelegate:delegate];
    return sdk;
}

-(void) fetchRatingForPlace:(NSString *)aPlaceId withDelegate:(id<CRSdkDelegate>)aDelegate
{    
    self.responseData = [[NSMutableData alloc] initWithCapacity:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:self.N_PLACE_RESSOURCE_URL,self.APIKey,aPlaceId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                        url];
    NSDictionary* headers = [NSHTTPCookie requestHeaderFieldsWithCookies:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    [request setAllHTTPHeaderFields:headers];
        
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [urlConnection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [urlConnection start];
}

- (NSURL *)urlForStoreLocatorRessource {
    return [NSURL URLWithString:[NSString stringWithFormat:self.N_STORE_LOCATOR_RESSOURCE_URL, self.APIKey]];
}

- (NSURL *)urlForWidgetRessourceForStroreId:(NSString *)storeId {
    return [NSURL URLWithString:[NSString stringWithFormat:self.N_WIDGET_RESSOURCE_URL, self.APIKey, storeId]];
}

- (NSString *)getApiKey {
    return self.APIKey;
}

#pragma mark NSURLRequestDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
        if ([delegate respondsToSelector:@selector(critizrPlaceRatingError:)]) {
            [delegate critizrPlaceRatingError:error];
        }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.responseData) {
        NSString *dataString = [NSString stringWithUTF8String:[self.responseData bytes]];
        [delegate critizrPlaceRatingFetched:[dataString doubleValue]];
        
    }
    [delegate critizrPlaceRatingError:nil];
}


@end
