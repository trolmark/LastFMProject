
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ADBaseDataSource : NSObject

/// The items represented by this data source.
@property (nonatomic, copy) NSArray *items;

/// Reset the content and loading state.
- (void)resetContent;

/// Find the item at the specified index path.
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/// Find the index paths of the specified item in the data source. An item may appear more than once in a given data source.
- (NSArray*)indexPathsForItem:(id)item;

/// Remove an item from the data source. This method should only be called as the result of a user action, such as tapping the "Delete" button in a swipe-to-delete gesture. Automatic removal of items due to outside changes should instead be handled by the data source itself — not the controller. Data sources must implement this to support swipe-to-delete.
- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath;

// Update item at index path
- (void) updateItemAtIndexPath:(NSIndexPath *)path withItem:(id) item;

-(void) addItems:(NSArray *)newItems;

- (void)setItems:(NSArray *)items;

- (NSUInteger)countOfItems;

@end
