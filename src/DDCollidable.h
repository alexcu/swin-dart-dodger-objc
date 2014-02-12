/**
 * @protocol    DDCollidable
 * @version     1.0
 * @author      Alex Cummaudo
 * @date        10 Sep 2013
 * @brief       Defines a protocol for all collidable sprites.
 */

#import <Foundation/Foundation.h>

// Forward reference classes referenced in interface
@class DDSprite, DDCollisionMask;

@protocol DDCollidable <NSObject>

// Required collidable implementation for all fallable sprites
/**
 * @brief   To check collision with any other DDSprite that 
 *          is also DDCollidable this calculates whether the
 *          collision masks of collidable sprites overrlap
 * @param   sprite
 *          The other sprite to check against overrlapping of
 *          my collision mask and their collision mask
 * @return  YES or NO where collision has occured or not
 */
-(BOOL)               collideWithSprite:(DDSprite<DDCollidable>*) sprite;

/**
 * @brief   An implicit declaration that all DDCollidable users
 *          should have a DDCollisionMask instance variable and
 *          this therefore allows access to that collision mask
 * @return  A DDCollision mask which thie DDCollidiable object has
 */
-(DDCollisionMask*)   getCollisionMask;

@end