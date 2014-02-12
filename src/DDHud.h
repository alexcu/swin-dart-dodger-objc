/**
 * @class   DDHud
 * @author  Alex Cummaudo
 * @date    22 Sep 2013
 * @brief   Defines the HUD class, which contains elements
 *          to be drawn for information relay to the player
 */

#import <Foundation/Foundation.h>

@interface DDHud : NSObject {
    SGFont* _smallFnt;  //!< Defines a large font for large HUD output
    SGFont* _largeFnt;  //!< Defines a small font for small HUD output
}

// Declare Methods
-(id)   init;
-(void) drawWithItems:(NSDictionary*) items;

@end
