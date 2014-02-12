#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"

@interface SGMatrix2D : NSObject
{
@package
    matrix2d data;
}

+ (void) updateMatrix2DsIn:(NSArray *)arr fromDataIn:(matrix2d *)firstPtr size:(int)sz;
+ (NSArray *) arrayOfMatrix2Ds:(matrix2d *)firstPtr size:(int)sz;
+ (void) getMatrix2Ds:(matrix2d *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz;

+ (SGMatrix2D *) matrix2DForData: (matrix2d)dat;

- (SGMatrix2D *)initWithMatrix2D:(matrix2d)dat;

- (matrix2d) data;
- (void) setData:(matrix2d)dat;


+ (SGMatrix2D *)identityMatrix;
+ (SGMatrix2D *)rotationMatrix:(float)deg;
+ (SGMatrix2D *)scaleMatrix:(float)scale;
+ (SGMatrix2D *)scaleMatrixByPoint:(SGPoint2D *)scale;
+ (SGMatrix2D *)matrixToScale:(SGPoint2D *)scale  rotate:(float)deg  translate:(SGPoint2D *)translate;
+ (SGMatrix2D *)translationMatrixDx:(float)dx  dy:(float)dy;
+ (SGMatrix2D *)translationMatrix:(SGPoint2D *)pt;






- (void)applyToTriangle:(SGTriangle *)tri;
- (void)applyToPoints:(NSArray *)pts;
- (SGVector *)multiplyByVector:(SGVector *)v;
- (SGMatrix2D *)multiplyByMatrix:(SGMatrix2D *)m2;
- (NSString *)description;

@end

@interface SGWrappedMatrix2D : SGMatrix2D
{
@package
    id       delegate;
    SEL      call_on_update;
    SEL      call_on_read;
}

+ (SGWrappedMatrix2D *) matrix2DWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;
- (id) initMatrix2DWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;

@end

