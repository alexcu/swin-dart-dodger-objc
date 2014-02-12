#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"

@interface SGTriangle : NSObject
{
@package
    triangle data;
}

+ (void) updateTrianglesIn:(NSArray *)arr fromDataIn:(triangle *)firstPtr size:(int)sz;
+ (NSArray *) arrayOfTriangles:(triangle *)firstPtr size:(int)sz;
+ (void) getTriangles:(triangle *)firstPtr fromArray:(const NSArray *)arr maxSize:(int)sz;

+ (SGTriangle *) triangleForData: (triangle)dat;

- (SGTriangle *)initWithTriangle:(triangle)dat;

- (triangle) data;
- (void) setData:(triangle)dat;








- (SGPoint2D *)barycenter;
- (NSString *)description;

@end

@interface SGWrappedTriangle : SGTriangle
{
@package
    id       delegate;
    SEL      call_on_update;
    SEL      call_on_read;
}

+ (SGWrappedTriangle *) triangleWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;
- (id) initTriangleWithDelegate:(id)del update:(SEL)sel1 andRead:(SEL)sel2;

@end

