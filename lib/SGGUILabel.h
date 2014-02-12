#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGGUILabel : NSObject <PointerWrapper>
{
@package
    guilabel pointer;
}

+ (NSArray *) arrayOfGUILabels:(guilabel *)firstPtr size:(int)sz;
+ (void) getGUILabels:(guilabel *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(guilabel)ptr;

- (id)initWithId:(guilabel)ptr; 





@end
