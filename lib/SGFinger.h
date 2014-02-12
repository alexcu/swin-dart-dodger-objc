#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"

@interface SGFinger : NSObject
{
@package
    finger data;
}

+ (void) updateFingersIn:(NSArray *)arr fromDataIn:(finger *)firstPtr size:(int)sz;
+ (NSArray *) arrayOfFingers:(finger *)firstPtr size:(int)sz;
+ (void) getFingers:(finger *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz;

+ (SGFinger *) fingerForData: (finger)dat;

- (SGFinger *)initWithFinger:(finger)dat;

- (finger) data;
- (void) setData:(finger)dat;






#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) SGPoint2D * lastPosition;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) BOOL down;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) unsigned short int pressure;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) unsigned short int lastPressure;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) SGPoint2D * position;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) SGPoint2D * positionDelta;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) long long id;
#endif


#if OBJC_NEW_PROPERTIES != 1
- (SGPoint2D *)lastPosition;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setLastPosition:(SGPoint2D *)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (BOOL)down;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setDown:(BOOL)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (unsigned short int)pressure;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setPressure:(unsigned short int)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (unsigned short int)lastPressure;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setLastPressure:(unsigned short int)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (SGPoint2D *)position;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setPosition:(SGPoint2D *)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (SGPoint2D *)positionDelta;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setPositionDelta:(SGPoint2D *)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (long long)id;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setId:(long long)value;
#endif

@end

@interface SGWrappedFinger : SGFinger
{
@package
    id       delegate;
    SEL      call_on_update;
    SEL      call_on_read;
}

+ (SGWrappedFinger *) fingerWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;
- (id) initFingerWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;

@end

