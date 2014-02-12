#import "SGGUIList.h"

#import <stdlib.h>

#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGGUIList : NSObject

+ (void) getGUILists:(guilist *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz
{
    int i;
    int count = [in_data count];
    count = count <= sz ? count : sz; //get min of sz and count
    for ( i = 0; i < count; i++ ) 
    {
        SGGUIList *obj = [in_data objectAtIndex:i];
        *(firstPtr + i) = obj->pointer;
    }
}

+ (NSArray *) arrayOfGUILists:(guilist *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGGUIList *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [SGGUIList createWithId: *(firstPtr + i)];
        [result addObject: obj];
    }
    
    return [result autorelease];
}

+ (id)createWithId:(guilist)ptr
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

- (id)initWithId:(guilist)ptr
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





@dynamic activeItemIndex;
@dynamic activeItemText;
@dynamic font;
@dynamic fontAlignment;
@dynamic itemCount;
@dynamic largestStartIndex;
@dynamic scrollIncrement;
@dynamic startAt;


- (int)activeItemIndex
{
    int result;
    result = sg_UserInterface_ListActiveItemIndex(self->pointer);
    return result;
}

- (void)setActiveItemIndex:(int)idx
{
    sg_UserInterface_ListSetActiveItemIndex(self->pointer, idx);
}

- (NSString *)activeItemText
{
    char result[2048];
    sg_UserInterface_ListActiveItemText(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (SGFont *)font
{
    SGFont * result;
    result = [SGFont createWithId:sg_UserInterface_ListFont(self->pointer)];
    return result;
}

- (void)setFont:(SGFont *)f
{
    sg_UserInterface_ListSetFont(self->pointer, f->pointer);
}

- (font_alignment)fontAlignment
{
    font_alignment result;
    result = (font_alignment)sg_UserInterface_ListFontAlignment(self->pointer);
    return result;
}

- (void)setFontAlignment:(font_alignment)align
{
    sg_UserInterface_ListSetFontAlignment(self->pointer, (int)align);
}

- (int)itemCount
{
    int result;
    result = sg_UserInterface_ListItemCount(self->pointer);
    return result;
}

- (int)largestStartIndex
{
    int result;
    result = sg_UserInterface_ListLargestStartIndex(self->pointer);
    return result;
}

- (int)scrollIncrement
{
    int result;
    result = sg_UserInterface_ListScrollIncrement(self->pointer);
    return result;
}

- (int)startAt
{
    int result;
    result = sg_UserInterface_ListStartAt(self->pointer);
    return result;
}

- (void)setStartAt:(int)idx
{
    sg_UserInterface_ListSetStartingAt(self->pointer, idx);
}

- (void)addBitmapItem:(SGBitmap *)img
{
    sg_UserInterface_AddItemByBitmap(self->pointer, img->pointer);
}

- (void)addImg:(SGBitmap *)img  andText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddBitmapAndTextItem(self->pointer, img->pointer, text_temp);
}

- (void)addBitmapCell:(SGBitmapCell *)img
{
    sg_UserInterface_ListAddItemWithCell(self->pointer, &img->data);
}

- (void)addBitmapCell:(SGBitmapCell *)img  andText:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ListAddItemWithCellAndText(self->pointer, &img->data, text_temp);
}

- (void)addTextItem:(NSString *)text
{
    char text_temp[[text length] + 1];
    [text getCString:text_temp maxLength:[text length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_AddItemByText(self->pointer, text_temp);
}

- (int)bitmapItemIndex:(SGBitmap *)img
{
    int result;
    result = sg_UserInterface_ListBitmapIndex(self->pointer, img->pointer);
    return result;
}

- (int)cellItemIndex:(SGBitmapCell *)img
{
    int result;
    result = sg_UserInterface_ListBitmapCellIndex(self->pointer, &img->data);
    return result;
}

- (void)clearItems
{
    sg_UserInterface_ListClearItems(self->pointer);
}

- (int)indexOfTextItem:(NSString *)value
{
    char value_temp[[value length] + 1];
    int result;
    [value getCString:value_temp maxLength:[value length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ListTextIndex(self->pointer, value_temp);
    return result;
}

- (NSString *)itemTextAtIndex:(int)idx
{
    char result[2048];
    sg_UserInterface_ListItemText(self->pointer, idx, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (void)removeItem:(int)idx
{
    sg_UserInterface_ListRemoveItem(self->pointer, idx);
}


@end
