/**
 * @class   DDBalloon
 * @author  Alex Cummaudo
 * @date    11 Sep 2013
 * @brief   Defines the class for the balloon object, 
 *          which allows the player to interact with
 *          in-game elements.
 */

// Import parent class
#import "DDSprite.h"

// Import protocol usage class
#import "DDCollidable.h"

// Forward reference classes referenced in interface
@class DDCollisionMask, DDGame;

@interface DDBalloon : DDSprite <DDCollidable>
{
    // Declare ivars
    int                 _health;                //!< Defines the value for the balloon's
                                                //!< health
    int                 _speed;                 //!< Defines the value for the balloon's speed
    BOOL                _isAlive;               //!< Defines the status of the balloon's
                                                //!< existance (dying or not dying)
    DDBalloon*          _duplicate;             //!< Defines a secondary DDBalloon, usually
                                                //!< always set to nil unless the balloon is
                                                //!< off the screen, in which case the
                                                //!< duplicate comes into action.
    DDCollisionMask*    _innerCollisionMask;    //!< Defines the innermost collision mask that
                                                //!< can make sigificant destruction to the
                                                //!< balloon (i.e. dart death)
    DDCollisionMask*    _outerCollisionMask;    //!< Defines the outer collision mask that
                                                //!< allows for collisions with simple objects
                                                //!< (e.g. health kits)
}

// Declare properties
@property               int                 health;             //!< Allows access to the
                                                                //!< balloon's health;
                                                                //!< used by DDGame to draw
                                                                //!< the health of the balloon
                                                                //!< on the HUD as well as
                                                                //!< within the internal
                                                                //!< implementation of
                                                                //!< DDBalloon for the
                                                                //!< duplicate balloon
                                                                //!< (i.e. _duplicate.health)
@property   (readonly)  BOOL                isAlive;            //!< Allows readonly access to
                                                                //!< the balloon's alive state
                                                                //!< for the DDGame to reverse
                                                                //!< score when balloon is
                                                                //!< dying
@property   (readonly)  DDCollisionMask*    innerCollisionMask; //!< Allows readonly access to
                                                                //!< the balloon's collision
                                                                //!< mask (inner).
                                                                //!< Used in DDCanvas in debug
                                                                //!< method to draw the
                                                                //!< collision mask as well as
                                                                //!< within the internal
                                                                //!< implementation of
                                                                //!< DDBalloon for the
                                                                //!< duplicate balloon
                                                                //!< (i.e. _duplicate.health).
                                                                //!< @note This is required
                                                                //!< in addition to the
                                                                //!< protocol implementation
                                                                //!< of getCollisionMask for
                                                                //!< DDCollidable sprites
                                                                //!< since it allows access
                                                                //!< to both collision masks
@property   (readonly)  DDCollisionMask*    outerCollisionMask; //!< Allows readonly access to
                                                                //!< the balloon's collision
                                                                //!< mask (outer)
                                                                //!< Used in DDCanvas in debug
                                                                //!< method to draw the
                                                                //!< collision mask as well as
                                                                //!< within the internal
                                                                //!< implementation of
                                                                //!< DDBalloon for the
                                                                //!< duplicate balloon
                                                                //!< (i.e. _duplicate.health).
                                                                //!< @note This is required
                                                                //!< in addition to the
                                                                //!< protocol implementation
                                                                //!< of getCollisionMask for
                                                                //!< DDCollidable sprites
                                                                //!< since it allows access
                                                                //!< to both collision masks

// Declare methods
-(id)   initInGame:(DDGame*) game;
-(void) moveInDirection:(DDDirection) dir;
-(void) checkOffScreen;
-(void) jiggle;
-(void) burst;
-(void) oneUp;

@end
