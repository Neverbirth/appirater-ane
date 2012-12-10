#import "AppiraterANE.h"
#import "Appirater.h"
#import "AppiraterNotifier.h"

FREContext AppirateCtx = nil;


@implementation AppiraterANE

#pragma mark - Singleton

static AppiraterANE *sharedInstance = nil;

+ (AppiraterANE *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }

    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

@end


#pragma mark - C interface

AppiraterNotifier * notifier;

DEFINE_ANE_FUNCTION(AppEnteredForeground) {
    uint32_t canPromptForRating;
    
    FREGetObjectAsBool(argv[0], &canPromptForRating);
    
    [Appirater appEnteredForeground:(BOOL)canPromptForRating];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(UserDidSignificantEvent) {
    uint32_t canPromptForRating;
    
    FREGetObjectAsBool(argv[0], &canPromptForRating);
    
    [Appirater userDidSignificantEvent:(BOOL)canPromptForRating];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(RateApp) {
    [Appirater rateApp];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(SetAppId) {
    uint32_t appIdLength;
    const uint8_t *appId;
    
    FREGetObjectAsUTF8(argv[0], &appIdLength, &appId);
    
    [Appirater setAppId:[[NSString stringWithUTF8String:(char *)appId] copy]];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(SetDaysUntilPrompt) {
    double days;
    
    FREGetObjectAsDouble(argv[0], &days);
    
    [Appirater setDaysUntilPrompt:days];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(SetUsesUntilPrompt) {
    int32_t value;
    
    FREGetObjectAsInt32(argv[0], &value);
    
    [Appirater setUsesUntilPrompt:(NSInteger)value];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(SetSignificantEventsUntilPrompt) {
    int32_t value;
    
    FREGetObjectAsInt32(argv[0], &value);
    
    [Appirater setSignificantEventsUntilPrompt:(NSInteger)value];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(SetTimeBeforeReminding) {
    double days;
    
    FREGetObjectAsDouble(argv[0], &days);
    
    [Appirater setTimeBeforeReminding:days];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(SetDebug) {
    uint32_t value;
    
    FREGetObjectAsBool(argv[0], &value);
    
    [Appirater setDebug:(BOOL)value];
    
    return NULL;
}


#pragma mark - ANE setup

/* AppirateExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void AppiraterExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
}

/* AppirateExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void AppiraterExtFinalizer(void* extData)
{

    // Nothing to clean up.

    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     * As a sample, the function isSupported is being provided.
     */
    *numFunctionsToTest = 9;

    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    func[0].name = (const uint8_t*) "appEnteredForeground";
    func[0].functionData = NULL;
    func[0].function = &AppEnteredForeground;

    func[1].name = (const uint8_t*) "userDidSignificantEvent";
    func[1].functionData = NULL;
    func[1].function = &UserDidSignificantEvent;
    
    func[2].name = (const uint8_t*) "rateApp";
    func[2].functionData = NULL;
    func[2].function = &RateApp;
    
    func[3].name = (const uint8_t*) "setAppId";
    func[3].functionData = NULL;
    func[3].function = &SetAppId;
    
    func[4].name = (const uint8_t*) "setDaysUntilPrompt";
    func[4].functionData = NULL;
    func[4].function = &SetDaysUntilPrompt;
    
    func[5].name = (const uint8_t*) "setUsesUntilPrompt";
    func[5].functionData = NULL;
    func[5].function = &SetUsesUntilPrompt;
    
    func[6].name = (const uint8_t*) "setSignificantEventsUntilPrompt";
    func[6].functionData = NULL;
    func[6].function = &SetSignificantEventsUntilPrompt;
    
    func[7].name = (const uint8_t*) "setTimeBeforeReminding";
    func[7].functionData = NULL;
    func[7].function = &SetTimeBeforeReminding;
    
    func[8].name = (const uint8_t*) "setDebug";
    func[8].functionData = NULL;
    func[8].function = &SetDebug;
    
    *functionsToSet = func;

    AppirateCtx = ctx;
    notifier = [[AppiraterNotifier alloc] init];
    [notifier setContext: ctx];
    [Appirater setDelegate: notifier];
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ContextFinalizer(FREContext ctx) 
{
    [notifier setContext: NULL];
    [notifier release];
    notifier = nil;
    
    AppirateCtx = nil;

    return;
}


