/**
 * @typedef DDCollisionMaskType
 * @brief   Defines the various types of collision masks
 *          that can exist for DDCollisionMasks.
 */
typedef enum DDCollisionMaskType
{
    RECTANGLE,  //!< For rectangular-shaped collision masks
    TRIANGLE    //!< For triangular-shaped collision masks
} DDCollisionMaskType;

/**
 * @class   DDCollisionMask
 * @author  Alex Cummaudo
 * @date    10 Sep 2013
 * @brief   Defines the collision mask object for objects that
 *          require collisions.
 */
#import <Foundation/Foundation.h>

// Import DDDirection Enumeration
#import "DDDirection.h"

// Forward reference classes referenced in interface
@class SGPoint2D;

@interface DDCollisionMask : NSObject
{
    // Declare ivars
    id          _maskShape; //!< Defines the collision mask shape required for
                            //!< this DDCollisionMask to have.
                            //!< @note  We use id type here since
                            //!<        we're not sure which kind
                            //!<        of SG shape we're going to
                            //!<        be initialised with.
    NSArray*    _points;    //!< Defines a collection of whereabouts each of the
                            //!< points in this mask's shape are.
}

@property (readonly)   NSArray *points;     //!< Defines readonly access to the points of the
                                            //!< collision mask shape, used by DDBalloon to
                                            //!< access each of its triangular collision
                                            //!< points in its collision triangle.
@property (readonly)   id       shape;      //!< Defines readonly access to the shape of the
                                            //!< collision mask (whatever that shape object
                                            //!< may be---hence the id type to return any
                                            //!< kind of object!).
                                            //!< Used by DDCollidable objects to determine
                                            //!< overlapping of collision mask shapes.

// Declare methods
-(id)   initAsRectangleAtPointA:(SGPoint2D*) pointA pointB:(SGPoint2D*) pointB;
-(id)   initAsTriangleAtPointA:(SGPoint2D*) pointA
                        pointB:(SGPoint2D*) pointB
                        pointC:(SGPoint2D*) pointC;
-(void) moveInDirection:(DDDirection)coord atSpeed:(int) speed;
-(void) updateWithPoints:(NSArray*)points;

@end
