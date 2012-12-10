//
//  AppiraterNotifier.m
//  Appirater
//
//  Created by Hector on 08/12/12.
//
//

#import "AppiraterNotifier.h"

@implementation AppiraterNotifier

-(void)appiraterDidDisplayAlert:(Appirater *)appirater {
    if (context != NULL)
        FREDispatchStatusEventAsync(context, (uint8_t *)"alertDisplayed", NULL);
}

-(void)appiraterDidDeclineToRate:(Appirater *)appirater {
    if (context != NULL)
        FREDispatchStatusEventAsync(context, (uint8_t *)"declinedToRate", NULL);
}

-(void)appiraterDidOptToRate:(Appirater *)appirater {
    if (context != NULL)
        FREDispatchStatusEventAsync(context, (uint8_t *)"didOptToRate", NULL);
}

-(void)appiraterDidOptToRemindLater:(Appirater *)appirater {
    if (context != NULL)
        FREDispatchStatusEventAsync(context, (uint8_t *)"didOptToRemindLater", NULL);
}

-(void)setContext:(FREContext)ctx {
    context = ctx;
}

@end
