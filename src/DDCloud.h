/**
 * @class   DDCloud
 * @author  Alex Cummaudo
 * @date    01 Oct 2013
 * @brief   Defines the class for a DDCloud, which
 *          allows for the creation of cloud objects
 *          which force the player to move in a certain
 *          direction.
 */

#import <Foundation/Foundation.h>

// Import the parent class
#import "DDCollidable.h"
#import "DDFallable.h"
#import "DDSprite.h"

// Forward reference classes referenced in interface
@class DDCollisionMask, DDGame;

@interface DDCloud : DDSprite <DDCollidable, DDFallable>
{
    // Declare ivars
    int                 _speed;         //!< Declares the cloud's speed
    DDCollisionMask*    _collisionMask; //!< Declares the collision mask for the cloud
    DDDirection         _movingDirection;   //!< Declares the direction in which this cloud
                                            //!< starts moving in
}

// Declare methods
-(id)   initInGame:(DDGame*) game inDirection:(DDDirection) dir;
-(void) fall;

@end
