#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"

@interface SGResolution : NSObject
{
@package
    resolution data;
}

+ (void) updateResolutionsIn:(NSArray *)arr fromDataIn:(resolution *)firstPtr size:(int)sz;
+ (NSArray *) arrayOfResolutions:(resolution *)firstPtr size:(int)sz;
+ (void) getResolutions:(resolution *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz;

+ (SGResolution *) resolutionForData: (resolution)dat;

- (SGResolution *)initWithResolution:(resolution)dat;

- (resolution) data;
- (void) setData:(resolution)dat;






#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int refreshRate;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int width;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int height;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) unsigned short int format;
#endif


#if OBJC_NEW_PROPERTIES != 1
- (int)refreshRate;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setRefreshRate:(int)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)width;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setWidth:(int)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)height;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setHeight:(int)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (unsigned short int)format;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setFormat:(unsigned short int)value;
#endif

@end

@interface SGWrappedResolution : SGResolution
{
@package
    id       delegate;
    SEL      call_on_update;
    SEL      call_on_read;
}

+ (SGWrappedResolution *) resolutionWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;
- (id) initResolutionWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;

@end

