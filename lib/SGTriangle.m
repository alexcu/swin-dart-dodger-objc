#import "SGTriangle.h"

#import <Foundation/NSInvocation.h>

#import "PointerManager.h"
#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGWrappedTriangle : SGTriangle

+ (SGWrappedTriangle *) triangleWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
{
    SGWrappedTriangle *ret = [[SGWrappedTriangle alloc] initTriangleWithDelegate:del update:sel1 andRead:sel2];
    [ret autorelease];
    return ret;
}

- (id)initTriangleWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
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
    
    SGTriangle *ret;
    [inv getReturnValue: &ret];
    data = ret->data;
}



@end


@implementation SGTriangle : NSObject

//
// Update the Triangle objects in the NSArray arr from the array pointed to by firstPtr.
// This is used to restore data to objects after calling a SwinGame method.
//
+ (void) updateTrianglesIn:(NSArray *)arr fromDataIn:(triangle *)firstPtr size:(int)sz
{
    int i;
    SGTriangle *current;
    
    for (i = 0; i < [arr count]; i++)
    {
        current = (SGTriangle *)[arr objectAtIndex: i];
        [current setData: *(firstPtr + i)];
    }
}

+ (NSArray *) arrayOfTriangles:(triangle *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGTriangle *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [[SGTriangle alloc] initWithTriangle: *(firstPtr + i)];
        [result addObject: obj];
        [obj release];
    }
    
    return [result autorelease];
}

+ (SGTriangle *) triangleForData: (triangle)dat
{
    SGTriangle *ret = [[SGTriangle alloc] initWithTriangle: dat];
    [ret autorelease];
    return ret;
}

+ (void) getTriangles:(triangle *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz
{
    int i, count = [arr count];
    count = count <= sz ? count: sz; //get min of count and sz
    
    for (i = 0; i < count; i++)
    {
        *(firstPtr + i) = [((SGTriangle *)[arr objectAtIndex: i]) data];
    }
}

- (SGTriangle *)initWithTriangle:(triangle)dat
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

- (triangle) data
{
    return data;
}

- (void) setData:(triangle)dat
{
    data = dat;
}








- (SGPoint2D *)barycenter
{
    SGPoint2D * result;
    result = [SGPoint2D point2DForData:sg_Geometry_TriangleBarycenter(&self->data)];
    return result;
}

- (NSString *)description
{
    char result[2048];
    sg_Geometry_TriangleToString(&self->data, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}


@end

