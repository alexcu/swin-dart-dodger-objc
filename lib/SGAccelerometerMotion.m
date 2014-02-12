#import "SGAccelerometerMotion.h"

#import <Foundation/NSInvocation.h>

#import "PointerManager.h"
#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGWrappedAccelerometerMotion : SGAccelerometerMotion

+ (SGWrappedAccelerometerMotion *) accelerometerMotionWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
{
    SGWrappedAccelerometerMotion *ret = [[SGWrappedAccelerometerMotion alloc] initAccelerometerMotionWithDelegate:del update:sel1 andRead:sel2];
    [ret autorelease];
    return ret;
}

- (id)initAccelerometerMotionWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
{
    self = [super init];
    if (self != nil)
    {
        //If self isn't nil then assign pointer.
        call_on_update = sel1;
        call_on_read   = sel2;
        delegate       = del;
        
        [delegate retain];
    }
    return self;
}

- (void) dealloc
{
    [delegate release];
    [super dealloc];
}

- (void) callUpdate
{
    if (delegate == nil || call_on_update == nil) return;
    
    NSMethodSignature *sig = [self methodSignatureForSelector:call_on_update];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature: sig];
    [inv setArgument:&self atIndex:2]; //first arg after self + _cmd (for call)
    [inv invokeWithTarget: delegate]; //call on the delegate
}

- (void) callRead
{
    if (delegate == nil || call_on_read == nil) return;
    
    NSMethodSignature *sig = [self methodSignatureForSelector:call_on_read];
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature: sig];
    [inv invokeWithTarget: delegate]; //call on the delegate
    
    SGAccelerometerMotion *ret;
    [inv getReturnValue: &ret];
    data = ret->data;
}


- (int)zAxis
{
    [self callRead];
    int result;
    result = data.z_axis;
    return result;
}

- (void)setZAxis:(int)value
{
    data.z_axis = value;
    [self callUpdate];
}

- (int)xAxis
{
    [self callRead];
    int result;
    result = data.x_axis;
    return result;
}

- (void)setXAxis:(int)value
{
    data.x_axis = value;
    [self callUpdate];
}

- (int)yAxis
{
    [self callRead];
    int result;
    result = data.y_axis;
    return result;
}

- (void)setYAxis:(int)value
{
    data.y_axis = value;
    [self callUpdate];
}


@end


@implementation SGAccelerometerMotion : NSObject

//
// Update the AccelerometerMotion objects in the NSArray arr from the array pointed to by firstPtr.
// This is used to restore data to objects after calling a SwinGame method.
//
+ (void) updateAccelerometerMotionsIn:(NSArray *)arr fromDataIn:(accelerometer_motion *)firstPtr size:(int)sz
{
    int i;
    SGAccelerometerMotion *current;
    
    for (i = 0; i < [arr count]; i++)
    {
        current = (SGAccelerometerMotion *)[arr objectAtIndex: i];
        [current setData: *(firstPtr + i)];
    }
}

+ (NSArray *) arrayOfAccelerometerMotions:(accelerometer_motion *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGAccelerometerMotion *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [[SGAccelerometerMotion alloc] initWithAccelerometerMotion: *(firstPtr + i)];
        [result addObject: obj];
        [obj release];
    }
    
    return [result autorelease];
}

+ (SGAccelerometerMotion *) accelerometerMotionForData: (accelerometer_motion)dat
{
    SGAccelerometerMotion *ret = [[SGAccelerometerMotion alloc] initWithAccelerometerMotion: dat];
    [ret autorelease];
    return ret;
}

+ (void) getAccelerometerMotions:(accelerometer_motion *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz
{
    int i, count = [arr count];
    count = count <= sz ? count: sz; //get min of count and sz
    
    for (i = 0; i < count; i++)
    {
        *(firstPtr + i) = [((SGAccelerometerMotion *)[arr objectAtIndex: i]) data];
    }
}

- (SGAccelerometerMotion *)initWithAccelerometerMotion:(accelerometer_motion)dat
{
    //Assign super's initialised value to the self pointer
    self = [super init];
    if (self != nil)
    {
        //If self isn't nil then assign pointer.
        data = dat;
    }
    return self;
}

- (accelerometer_motion) data
{
    return data;
}

- (void) setData:(accelerometer_motion)dat
{
    data = dat;
}




@dynamic zAxis;
@dynamic xAxis;
@dynamic yAxis;




- (int)zAxis
{
    int result;
    result = data.z_axis;
    return result;
}

- (void)setZAxis:(int)value
{
    data.z_axis = value;
}

- (int)xAxis
{
    int result;
    result = data.x_axis;
    return result;
}

- (void)setXAxis:(int)value
{
    data.x_axis = value;
}

- (int)yAxis
{
    int result;
    result = data.y_axis;
    return result;
}

- (void)setYAxis:(int)value
{
    data.y_axis = value;
}


@end

