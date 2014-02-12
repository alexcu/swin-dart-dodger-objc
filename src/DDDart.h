/**
 * @class   DDDart
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class for the singular dart object,
 *          which falls from the screen in hope to hit and
 *          hurt the player.
 */

// Import the parent class
#import "DDSprite.h"

// Import protocol usage class
#import "DDCollidable.h"
#import "DDFallable.h"

// Forward reference classes referenced in interface
@class DDCollisionMask, DDGame;

@interface DDDart : DDSprite <DDCollidable, DDFallable>
{
    // Declare ivars
    int                 _speed;         //!< Declares the dart's speed
    DDCollisionMask*    _collisionMask; //!< Declares the collision mask for the dart
}

// Declare methods
-(id)   initInGame:(DDGame*) game;
-(void) fall;

@end
