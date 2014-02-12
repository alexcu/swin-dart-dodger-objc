#import "SGResolution.h"

#import <Foundation/NSInvocation.h>

#import "PointerManager.h"
#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGWrappedResolution : SGResolution

+ (SGWrappedResolution *) resolutionWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
{
    SGWrappedResolution *ret = [[SGWrappedResolution alloc] initResolutionWithDelegate:del update:sel1 andRead:sel2];
    [ret autorelease];
    return ret;
}

- (id)initResolutionWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
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
    
    SGResolution *ret;
    [inv getReturnValue: &ret];
    data = ret->data;
}


- (int)refreshRate
{
    [self callRead];
    int result;
    result = data.refresh_rate;
    return result;
}

- (void)setRefreshRate:(int)value
{
    data.refresh_rate = value;
    [self callUpdate];
}

- (int)width
{
    [self callRead];
    int result;
    result = data.width;
    return result;
}

- (void)setWidth:(int)value
{
    data.width = value;
    [self callUpdate];
}

- (int)height
{
    [self callRead];
    int result;
    result = data.height;
    return result;
}

- (void)setHeight:(int)value
{
    data.height = value;
    [self callUpdate];
}

- (unsigned short int)format
{
    [self callRead];
    unsigned short int result;
    result = data.format;
    return result;
}

- (void)setFormat:(unsigned short int)value
{
    data.format = value;
    [self callUpdate];
}


@end


@implementation SGResolution : NSObject

//
// Update the Resolution objects in the NSArray arr from the array pointed to by firstPtr.
// This is used to restore data to objects after calling a SwinGame method.
//
+ (void) updateResolutionsIn:(NSArray *)arr fromDataIn:(resolution *)firstPtr size:(int)sz
{
    int i;
    SGResolution *current;
    
    for (i = 0; i < [arr count]; i++)
    {
        current = (SGResolution *)[arr objectAtIndex: i];
        [current setData: *(firstPtr + i)];
    }
}

+ (NSArray *) arrayOfResolutions:(resolution *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGResolution *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [[SGResolution alloc] initWithResolution: *(firstPtr + i)];
        [result addObject: obj];
        [obj release];
    }
    
    return [result autorelease];
}

+ (SGResolution *) resolutionForData: (resolution)dat
{
    SGResolution *ret = [[SGResolution alloc] initWithResolution: dat];
    [ret autorelease];
    return ret;
}

+ (void) getResolutions:(resolution *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz
{
    int i, count = [arr count];
    count = count <= sz ? count: sz; //get min of count and sz
    
    for (i = 0; i < count; i++)
    {
        *(firstPtr + i) = [((SGResolution *)[arr objectAtIndex: i]) data];
    }
}

- (SGResolution *)initWithResolution:(resolution)dat
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

- (resolution) data
{
    return data;
}

- (void) setData:(resolution)dat
{
    data = dat;
}




@dynamic refreshRate;
@dynamic width;
@dynamic height;
@dynamic format;




- (int)refreshRate
{
    int result;
    result = data.refresh_rate;
    return result;
}

- (void)setRefreshRate:(int)value
{
    data.refresh_rate = value;
}

- (int)width
{
    int result;
    result = data.width;
    return result;
}

- (void)setWidth:(int)value
{
    data.width = value;
}

- (int)height
{
    int result;
    result = data.height;
    return result;
}

- (void)setHeight:(int)value
{
    data.height = value;
}

- (unsigned short int)format
{
    unsigned short int result;
    result = data.format;
    return result;
}

- (void)setFormat:(unsigned short int)value
{
    data.format = value;
}


@end

