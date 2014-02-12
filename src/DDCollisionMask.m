/**
 * @class   DDCollisionMask
 * @author  Alex Cummaudo
 * @date    10 Sep 2013
 * @brief   Defines the collision mask object for objects that
 *          require collisions.
 */

// Import SwinGame Framework
#import "SwinGame.h"

// Import my interface
#import "DDCollisionMask.h"

@implementation DDCollisionMask

@synthesize points = _points;
@synthesize shape  = _maskShape;

/**
 * @brief   Manual synthesis for centre of mask which
 *          uses the SwinGame function to return the
 *          centrepoint of the mask, either a triangle
 *          or a rectangle.
 * @return  The centrepoint of the shape of the collison mask
 */
-(SGPoint2D*) maskCentre
{
    // For Rectangles
    if ([_maskShape isKindOfClass:[SGRectangle class]])
    {
        return [SGGeometry rectangleCenter:(SGRectangle*)_maskShape];
    }
    // For Triangles
    if ([_maskShape isKindOfClass:[SGTriangle class]])
    {
        return [SGGeometry triangleBarycenter:(SGTriangle*)_maskShape];
    }
    return nil;
}

/**
 * @brief   Constructor for a rectangle-shape collision
 *          mask, taking in the 2 points
 * @param   pointA
 *          First point in this rectangle
 * @param   pointB
 *          Second point in this rectangle
 * @return  The class's self pointer
 */
-(id)initAsRectangleAtPointA:(SGPoint2D*) pointA pointB:(SGPoint2D*) pointB
{
    if (self = [super init])
    {
        _points     = [[NSMutableArray alloc] initWithObjects:pointA, pointB, nil];
        // Allocate memory so that the NSObject-typed variable
        // now holds a SGRectangle; i.e. assignment polymorphism
        _maskShape  = [[SGRectangle alloc] init];
        _maskShape  = [SGGeometry createRectangle:pointA
                                               to:pointB];
    }
    return self;
}

/**
 * @brief   Constructor for a triangle-shape collision
 *          mask, taking in the 3 points
 * @param   pointA
 *          First point in this triangle
 * @param   pointB
 *          Second point in this triangle
 * @param   pointC
 *          Third point in this triangle
 * @return  The class's self pointer
 */
-(id)initAsTriangleAtPointA:(SGPoint2D*) pointA
                     pointB:(SGPoint2D*) pointB
                     pointC:(SGPoint2D*) pointC
{
    if (self = [super init])
    {
        _points     = [[NSMutableArray alloc] initWithObjects:pointA, pointB, pointC, nil];
        // Allocate memory so that the NSObject-typed variable
        // now holds a SGTriangle; i.e. assignment polymorphism
        _maskShape  = [[SGTriangle alloc] init];
        _maskShape  = [SGGeometry createTrianglePtA:pointA
                                                ptB:pointB
                                                ptC:pointC];
    }
    return self;
}

/**
 * @brief   Moves every point in the _maskShape at a given speed
 *          in a given direction.
 * @param   coord
 *          Direction for each point to move towards
 * @param   speed
 *          Speed in which each point should move at
 */
-(void) moveInDirection:(DDDirection)coord atSpeed:(int) speed
{
    if (coord == DDLEFT)    { for (SGPoint2D* point in _points) point.x -= speed; }
    if (coord == DDRIGHT)   { for (SGPoint2D* point in _points) point.x += speed; }
    if (coord == DDUP)      { for (SGPoint2D* point in _points) point.y -= speed; }
    if (coord == DDDOWN)    { for (SGPoint2D* point in _points) point.y += speed; }
    [self updateWithPoints:_points];
}

/**
 * @brief   Updates the position of the mask by iterating
 *          through every point on the shape and relocating
 *          it to the given points array.
 * @param   points
 *          What each of the local _points will be replaced with
 */
-(void) updateWithPoints:(NSArray*)points
{
    _points = points;
    if      ([_maskShape isKindOfClass:[SGRectangle class]])
    {
        _maskShape = [SGGeometry rectangleFrom:[_points objectAtIndex:0]
                                            to:[_points objectAtIndex:1]];
    }
    else if ([_maskShape isKindOfClass:[SGTriangle  class]])
    {
        _maskShape = [SGGeometry triangleFromPtA:[_points objectAtIndex:0]
                                             ptB:[_points objectAtIndex:1]
                                             ptC:[_points objectAtIndex:2]];
    }
}

@end