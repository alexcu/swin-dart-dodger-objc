#import "SGMatrix2D.h"

#import <Foundation/NSInvocation.h>

#import "PointerManager.h"
#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGWrappedMatrix2D : SGMatrix2D

+ (SGWrappedMatrix2D *) matrix2DWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
{
    SGWrappedMatrix2D *ret = [[SGWrappedMatrix2D alloc] initMatrix2DWithDelegate:del update:sel1 andRead:sel2];
    [ret autorelease];
    return ret;
}

- (id)initMatrix2DWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2
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
    
    SGMatrix2D *ret;
    [inv getReturnValue: &ret];
    data = ret->data;
}



@end


@implementation SGMatrix2D : NSObject

//
// Update the Matrix2D objects in the NSArray arr from the array pointed to by firstPtr.
// This is used to restore data to objects after calling a SwinGame method.
//
+ (void) updateMatrix2DsIn:(NSArray *)arr fromDataIn:(matrix2d *)firstPtr size:(int)sz
{
    int i;
    SGMatrix2D *current;
    
    for (i = 0; i < [arr count]; i++)
    {
        current = (SGMatrix2D *)[arr objectAtIndex: i];
        [current setData: *(firstPtr + i)];
    }
}

+ (NSArray *) arrayOfMatrix2Ds:(matrix2d *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGMatrix2D *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [[SGMatrix2D alloc] initWithMatrix2D: *(firstPtr + i)];
        [result addObject: obj];
        [obj release];
    }
    
    return [result autorelease];
}

+ (SGMatrix2D *) matrix2DForData: (matrix2d)dat
{
    SGMatrix2D *ret = [[SGMatrix2D alloc] initWithMatrix2D: dat];
    [ret autorelease];
    return ret;
}

+ (void) getMatrix2Ds:(matrix2d *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz
{
    int i, count = [arr count];
    count = count <= sz ? count: sz; //get min of count and sz
    
    for (i = 0; i < count; i++)
    {
        *(firstPtr + i) = [((SGMatrix2D *)[arr objectAtIndex: i]) data];
    }
}

- (SGMatrix2D *)initWithMatrix2D:(matrix2d)dat
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

- (matrix2d) data
{
    return data;
}

- (void) setData:(matrix2d)dat
{
    data = dat;
}


+ (SGMatrix2D *)identityMatrix
{
    SGMatrix2D * result;
    result = [SGMatrix2D matrix2DForData:sg_Geometry_IdentityMatrix()];
    return result;
}

+ (SGMatrix2D *)rotationMatrix:(float)deg
{
    SGMatrix2D * result;
    result = [SGMatrix2D matrix2DForData:sg_Geometry_RotationMatrix(deg)];
    return result;
}

+ (SGMatrix2D *)scaleMatrix:(float)scale
{
    SGMatrix2D * result;
    result = [SGMatrix2D matrix2DForData:sg_Geometry_ScaleMatrix(scale)];
    return result;
}

+ (SGMatrix2D *)scaleMatrixByPoint:(SGPoint2D *)scale
{
    SGMatrix2D * result;
    result = [SGMatrix2D matrix2DForData:sg_Geometry_ScaleMatrixByPoint(&scale->data)];
    return result;
}

+ (SGMatrix2D *)matrixToScale:(SGPoint2D *)scale  rotate:(float)deg  translate:(SGPoint2D *)translate
{
    SGMatrix2D * result;
    result = [SGMatrix2D matrix2DForData:sg_Geometry_ScaleRotateTranslateMatrix(&scale->data, deg, &translate->data)];
    return result;
}

+ (SGMatrix2D *)translationMatrixDx:(float)dx  dy:(float)dy
{
    SGMatrix2D * result;
    result = [SGMatrix2D matrix2DForData:sg_Geometry_TranslationMatrix(dx, dy)];
    return result;
}

+ (SGMatrix2D *)translationMatrix:(SGPoint2D *)pt
{
    SGMatrix2D * result;
    result = [SGMatrix2D matrix2DForData:sg_Geometry_TranslationMatrixPt(&pt->data)];
    return result;
}







- (void)applyToTriangle:(SGTriangle *)tri
{
    sg_Geometry_ApplyMatrix(&self->data, &tri->data);
}

- (void)applyToPoints:(NSArray *)pts
{
    point2d pts_temp[[pts count]];
    [SGPoint2D getPoint2Ds:pts_temp fromArray:pts maxSize:[pts count]];
    sg_Geometry_ApplyMatrixToPoints(&self->data, pts_temp, [pts count]);
    [SGPoint2D updatePoint2DsIn:pts fromDataIn:pts_temp size:[pts count]];
}

- (SGVector *)multiplyByVector:(SGVector *)v
{
    SGVector * result;
    result = [SGVector vectorForData:sg_Geometry_MatrixMultiplyVector(&self->data, &v->data)];
    return result;
}

- (SGMatrix2D *)multiplyByMatrix:(SGMatrix2D *)m2
{
    SGMatrix2D * result;
    result = [SGMatrix2D matrix2DForData:sg_Geometry_MatrixMultiply(&self->data, &m2->data)];
    return result;
}

- (NSString *)description
{
    char result[2048];
    sg_Geometry_MatrixToString(&self->data, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}


@end

