/**
 * @class   DDHealth
 * @author  Alex Cummaudo
 * @date    22 Sep 2013
 * @brief   Defines the object for a health kit, which
 *          exists to boost player health
 */

// Import the parent class
#import "DDSprite.h"

// Import protocol usage class
#import "DDCollidable.h"
#import "DDFallable.h"

// Forward reference classes referenced in interface
@class DDCollisionMask, DDGame;

@interface DDHealth : DDSprite <DDCollidable, DDFallable>
{
    // Declare ivars
    int                 _speed;         //!< Declares the health kit's speed
    DDCollisionMask*    _collisionMask; //!< Declares the collision mask for the health kit
}

// Declare methods
-(id)   initInGame:(DDGame*) game;
-(void) fall;

@end
