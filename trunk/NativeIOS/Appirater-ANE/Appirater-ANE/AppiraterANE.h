#import "FlashRuntimeExtensions.h"

@interface AppiraterANE : NSObject

+ (AppiraterANE *)sharedInstance;

@end


// C interface


DEFINE_ANE_FUNCTION(AppEnteredForeground);
DEFINE_ANE_FUNCTION(UserDidSignificantEvent);
DEFINE_ANE_FUNCTION(RateApp);

DEFINE_ANE_FUNCTION(SetAppId);
DEFINE_ANE_FUNCTION(SetDaysUntilPrompt);
DEFINE_ANE_FUNCTION(SetUsesUntilPrompt);
DEFINE_ANE_FUNCTION(SetSignificantEventsUntilPrompt);
DEFINE_ANE_FUNCTION(SetTimeBeforeReminding);
DEFINE_ANE_FUNCTION(SetDebug);


// ANE setup

/* AppirateExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
*/
void AppiraterExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

/* AppirateExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
*/
void AppiraterExtFinalizer(void* extData);

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
*/
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
*/
void ContextFinalizer(FREContext ctx);


