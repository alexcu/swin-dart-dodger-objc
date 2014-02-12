/**
 * @protocol    DDFallable
 * @version     1.0
 * @author      Alex Cummaudo
 * @date        10 Sep 2013
 * @brief       Defines a protocol for all sprites which fall from
 *              top to bottom
 */

#import <Foundation/Foundation.h>

@protocol DDFallable <NSObject>

/**
 * @brief   A required fallable implementation for 
 *          all fallable sprites, wherein the fall
 *          method pushes them vertically downwards
 */
-(void) fall;

@end
