#import "SGRegion.h"

#import <stdlib.h>

#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGRegion : NSObject

+ (void) getRegions:(region *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz
{
    int i;
    int count = [in_data count];
    count = count <= sz ? count : sz; //get min of sz and count
    for ( i = 0; i < count; i++ ) 
    {
        SGRegion *obj = [in_data objectAtIndex:i];
        *(firstPtr + i) = obj->pointer;
    }
}

+ (NSArray *) arrayOfRegions:(region *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGRegion *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [SGRegion createWithId: *(firstPtr + i)];
        [result addObject: obj];
    }
    
    return [result autorelease];
}

+ (id)createWithId:(region)ptr
{
    if (ptr == nil) return nil;
    id obj = [PointerManager objectForKey: (id)ptr];
    
    if (obj == nil)
    {
        // Create and assign to obj...
        obj = [[[self alloc] initWithId:ptr] autorelease];
    }
    
    return obj;
}

- (id)initWithId:(region)ptr
{
    if (ptr == nil)
    {
        [self release];
        return nil;
    }
    //Assign super's initialised value to the self pointer
    self = [super init];
    if (self != nil)
    {
        //If self isn't nil then assign pointer.
        pointer = ptr;
        [PointerManager registerObject:self withKey:(id)ptr];
    }
    return self;
}

- (void)releasePointer
{
    pointer = nil;
}





@dynamic checkboxState;
@dynamic height;
@dynamic iD;
@dynamic list;
@dynamic listActiveItemIndex;
@dynamic listFont;
@dynamic listFontAlignment;
@dynamic listItemCount;
@dynamic listItemText;
@dynamic listStartAt;
@dynamic parentPanel;
@dynamic regionActive;
@dynamic textboxFont;
@dynamic textboxText;
@dynamic width;
@dynamic x;
@dynamic y;


- (BOOL)checkboxState
{
    BOOL result;
    result = sg_UserInterface_CheckboxStateFromRegion(self->pointer) != 0;
    return result;
}

- (void)setCheckboxState:(BOOL)val
{
    sg_UserInterface_CheckboxSetStateFromRegion(self->pointer, (val ? 1 : 0));
}

- (int)height
{
    int result;
    result = sg_UserInterface_RegionHeight(self->pointer);
    return result;
}

- (NSString *)iD
{
    char result[2048];
    sg_UserInterface_RegionID(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (SGGUIList *)list
{
    SGGUIList * result;
    result = [SGGUIList createWithId:sg_UserInterface_ListFromRegion(self->pointer)];
    return result;
}

- (int)listActiveItemIndex
{
    int result;
    result = sg_UserInterface_ListActiveItemIndexFromRegion(self->pointer);
    return result;
}

- (SGFont *)listFont
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_ListFontFromRegion(self->pointer)];
    return result;
}

- (font_alignment)listFontAlignment
{
    font_alignment result;
    result = (font_alignment)sg_UserInterface_ListFontAlignmentFromRegion(self->pointer);
    return result;
}

- (void)setListFontAlignment:(font_alignment)align
{
    sg_UserInterface_ListSetFontAlignmentFromRegion(self->pointer, (int)align);
}

- (int)listItemCount
{
    int result;
    result = sg_UserInterface_ListItemCountFromRegion(self->pointer);
    return result;
}

- (NSString *)listItemText
{
    char result[2048];
    sg_UserInterface_ListActiveItemTextFromRegion(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (int)listStartAt
{
    int result;
    result = sg_UserInterface_ListStartingAtFromRegion(self->pointer);
    return result;
}

- (void)setListStartAt:(int)idx
{
    sg_UserInterface_ListSetStartingAtFromRegion(self->pointer, idx);
}

- (SGPanel *)parentPanel
{
    SGPanel * result;
    result = [SGPanel createWithId:sg_UserInterface_RegionPanel(self->pointer)];
    return result;
}

- (BOOL)regionActive
{
    BOOL result;
    result = sg_UserInterface_RegionActive(self->pointer) != 0;
    return result;
}

- (void)setRegionActive:(BOOL)b
{
    sg_UserInterface_SetRegionActive(self->pointer, (b ? 1 : 0));
}

- (SGFont *)textboxFont
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_TextBoxFontFromRegion(self->pointer)];
    return result;
}

- (NSString *)textboxText
{
    char result[2048];
    sg_UserInterface_TextboxTextFromRegion(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (void)setTextboxText:(NSString *)s
{
    char s_temp[[s length] + 1];
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_TextboxSetTextFromRegion(self->pointer, s_temp);
}

- (int)width
{
    int result;
    result = sg_UserInterface_RegionWidth(self->pointer);
    return result;
}

- (float)x
{
    float result;
    result = sg_UserInterface_RegionX(self->pointer);
    return result;
}

- (float)y
{
    float result;
    result = sg_UserInterface_RegionY(self->pointer);
    return result;
}

- (void)addBitmapCell:(SGBitmapCell *)img
{
    sg_UserInterface_ListAddItemWithCellFromRegion(self->pointer, &img->data);
}

- (void)addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddItemWithCellAndTextFromRegion(self->pointer, &img->data, text_temp);
}

- (void)listAddBitmap:(SGBitmap *)img  andText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddBitmapAndTextItemFromRegion(self->pointer, img->pointer, text_temp);
}

- (void)listAddBitmapItem:(SGBitmap *)img
{
    sg_UserInterface_ListAddItemByBitmapFromRegion(self->pointer, img->pointer);
}

- (void)listAddTextItem:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddItemByTextFromRegion(self->pointer, text_temp);
}

- (void)listClearItems
{
    sg_UserInterface_ListClearItemsFromRegion(self->pointer);
}

- (NSString *)listItemTextAtIndex:(int)idx
{
    char result[2048];
    sg_UserInterface_ListItemTextFromRegion(self->pointer, idx, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (void)listRemoveActiveItem
{
    sg_UserInterface_ListRemoveActiveItemFromRegion(self->pointer);
}

- (void)registerEventCallback:(guievent_callback)callback
{
    sg_UserInterface_RegisterEventCallback(self->pointer, callback);
}

- (void)toggleActive
{
    sg_UserInterface_ToggleRegionActive(self->pointer);
}


@end
