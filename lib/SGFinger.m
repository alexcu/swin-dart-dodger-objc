#import "SGFinger.h"

#import <Foundation/NSInvocation.h>

#import "PointerManager.h"
#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGWrappedFinger : SGFinger

+ (SGWrappedFinger *) fingerWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
{
    SGWrappedFinger *ret = [[SGWrappedFinger alloc] initFingerWithDelegate:del update:sel1 andRead:sel2];
    [ret autorelease];
    return ret;
}

- (id)initFingerWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
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
    
    SGFinger *ret;
    [inv getReturnValue: &ret];
    data = ret->data;
}


- (SGPoint2D *)lastPosition
{
    [self callRead];
    SGPoint2D * result;
    result = [SGPoint2D point2DForData:data.last_position];
    return result;
}

- (void)setLastPosition:(SGPoint2D *)value
{
    data.last_position = value->data;
    [self callUpdate];
}

- (BOOL)down
{
    [self callRead];
    BOOL result;
    result = data.down != 0;
    return result;
}

- (void)setDown:(BOOL)value
{
    data.down = (value ? 1 : 0);
    [self callUpdate];
}

- (unsigned short int)pressure
{
    [self callRead];
    unsigned short int result;
    result = data.pressure;
    return result;
}

- (void)setPressure:(unsigned short int)value
{
    data.pressure = value;
    [self callUpdate];
}

- (unsigned short int)lastPressure
{
    [self callRead];
    unsigned short int result;
    result = data.last_pressure;
    return result;
}

- (void)setLastPressure:(unsigned short int)value
{
    data.last_pressure = value;
    [self callUpdate];
}

- (SGPoint2D *)position
{
    [self callRead];
    SGPoint2D * result;
    result = [SGPoint2D point2DForData:data.position];
    return result;
}

- (void)setPosition:(SGPoint2D *)value
{
    data.position = value->data;
    [self callUpdate];
}

- (SGPoint2D *)positionDelta
{
    [self callRead];
    SGPoint2D * result;
    result = [SGPoint2D point2DForData:data.position_delta];
    return result;
}

- (void)setPositionDelta:(SGPoint2D *)value
{
    data.position_delta = value->data;
    [self callUpdate];
}

- (long long)id
{
    [self callRead];
    long long result;
    result = data.id;
    return result;
}

- (void)setId:(long long)value
{
    data.id = value;
    [self callUpdate];
}


@end


@implementation SGFinger : NSObject

//
// Update the Finger objects in the NSArray arr from the array pointed to by firstPtr.
// This is used to restore data to objects after calling a SwinGame method.
//
+ (void) updateFingersIn:(NSArray *)arr fromDataIn:(finger *)firstPtr size:(int)sz
{
    int i;
    SGFinger *current;
    
    for (i = 0; i < [arr count]; i++)
    {
        current = (SGFinger *)[arr objectAtIndex: i];
        [current setData: *(firstPtr + i)];
    }
}

+ (NSArray *) arrayOfFingers:(finger *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGFinger *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [[SGFinger alloc] initWithFinger: *(firstPtr + i)];
        [result addObject: obj];
        [obj release];
    }
    
    return [result autorelease];
}

+ (SGFinger *) fingerForData: (finger)dat
{
    SGFinger *ret = [[SGFinger alloc] initWithFinger: dat];
    [ret autorelease];
    return ret;
}

+ (void) getFingers:(finger *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz
{
    int i, count = [arr count];
    count = count <= sz ? count: sz; //get min of count and sz
    
    for (i = 0; i < count; i++)
    {
        *(firstPtr + i) = [((SGFinger *)[arr objectAtIndex: i]) data];
    }
}

- (SGFinger *)initWithFinger:(finger)dat
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

- (finger) data
{
    return data;
}

- (void) setData:(finger)dat
{
    data = dat;
}




@dynamic lastPosition;
@dynamic down;
@dynamic pressure;
@dynamic lastPressure;
@dynamic position;
@dynamic positionDelta;
@dynamic id;




- (SGPoint2D *)lastPosition
{
    SGPoint2D * result;
    result = [SGPoint2D point2DForData:data.last_position];
    return result;
}

- (void)setLastPosition:(SGPoint2D *)value
{
    data.last_position = value->data;
}

- (BOOL)down
{
    BOOL result;
    result = data.down != 0;
    return result;
}

- (void)setDown:(BOOL)value
{
    data.down = (value ? 1 : 0);
}

- (unsigned short int)pressure
{
    unsigned short int result;
    result = data.pressure;
    return result;
}

- (void)setPressure:(unsigned short int)value
{
    data.pressure = value;
}

- (unsigned short int)lastPressure
{
    unsigned short int result;
    result = data.last_pressure;
    return result;
}

- (void)setLastPressure:(unsigned short int)value
{
    data.last_pressure = value;
}

- (SGPoint2D *)position
{
    SGPoint2D * result;
    result = [SGPoint2D point2DForData:data.position];
    return result;
}

- (void)setPosition:(SGPoint2D *)value
{
    data.position = value->data;
}

- (SGPoint2D *)positionDelta
{
    SGPoint2D * result;
    result = [SGPoint2D point2DForData:data.position_delta];
    return result;
}

- (void)setPositionDelta:(SGPoint2D *)value
{
    data.position_delta = value->data;
}

- (long long)id
{
    long long result;
    result = data.id;
    return result;
}

- (void)setId:(long long)value
{
    data.id = value;
}


@end

