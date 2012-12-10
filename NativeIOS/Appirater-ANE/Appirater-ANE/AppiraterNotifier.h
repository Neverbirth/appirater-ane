//
//  AppiraterNotifier.h
//  Appirater
//
//  Created by Hector on 08/12/12.
//
//

#import <Foundation/Foundation.h>
#import "AppiraterDelegate.h"
#import "FlashRuntimeExtensions.h"

@interface AppiraterNotifier : NSObject<AppiraterDelegate> {
    FREContext context;
}

-(void)setContext:(FREContext)ctx;

@end
