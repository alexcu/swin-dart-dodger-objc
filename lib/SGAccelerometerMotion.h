#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"

@interface SGAccelerometerMotion : NSObject
{
@package
    accelerometer_motion data;
}

+ (void) updateAccelerometerMotionsIn:(NSArray *)arr fromDataIn:(accelerometer_motion *)firstPtr size:(int)sz;
+ (NSArray *) arrayOfAccelerometerMotions:(accelerometer_motion *)firstPtr size:(int)sz;
+ (void) getAccelerometerMotions:(accelerometer_motion *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz;

+ (SGAccelerometerMotion *) accelerometerMotionForData: (accelerometer_motion)dat;

- (SGAccelerometerMotion *)initWithAccelerometerMotion:(accelerometer_motion)dat;

- (accelerometer_motion) data;
- (void) setData:(accelerometer_motion)dat;






#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int zAxis;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int xAxis;
#endif
#if OBJC_NEW_PROPERTIES
@property (assign, readwrite) int yAxis;
#endif


#if OBJC_NEW_PROPERTIES != 1
- (int)zAxis;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setZAxis:(int)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)xAxis;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setXAxis:(int)value;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (int)yAxis;
#endif
#if OBJC_NEW_PROPERTIES != 1
- (void)setYAxis:(int)value;
#endif

@end

@interface SGWrappedAccelerometerMotion : SGAccelerometerMotion
{
@package
    id       delegate;
    SEL      call_on_update;
    SEL      call_on_read;
}

+ (SGWrappedAccelerometerMotion *) accelerometerMotionWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;
- (id) initAccelerometerMotionWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;

@end

