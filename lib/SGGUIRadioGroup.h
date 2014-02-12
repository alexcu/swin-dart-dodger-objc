#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGGUIRadioGroup : NSObject <PointerWrapper>
{
@package
    guiradio_group pointer;
}

+ (NSArray *) arrayOfGUIRadioGroups:(guiradio_group *)firstPtr size:(int)sz;
+ (void) getGUIRadioGroups:(guiradio_group *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(guiradio_group)ptr;

- (id)initWithId:(guiradio_group)ptr; 

- (id)initOnPanel:(SGPanel *)pnl  withId :(NSString *)id;




@end
