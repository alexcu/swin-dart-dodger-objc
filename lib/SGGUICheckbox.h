#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGGUICheckbox : NSObject <PointerWrapper>
{
@package
    guicheckbox pointer;
}

+ (NSArray *) arrayOfGUICheckboxs:(guicheckbox *)firstPtr size:(int)sz;
+ (void) getGUICheckboxs:(guicheckbox *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(guicheckbox)ptr;

- (id)initWithId:(guicheckbox)ptr; 





@end
