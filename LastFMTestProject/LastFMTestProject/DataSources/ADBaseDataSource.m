#import "ADBaseDataSource.h"

@implementation ADBaseDataSource


- (void)resetContent
{
    self.items = @[];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger itemIndex = indexPath.item;
    if (itemIndex < [_items count])
        return _items[itemIndex];
    
    return nil;
}

- (void) updateItemAtIndexPath:(NSIndexPath *)path withItem:(id) item
{
    NSInteger fromIndex = path.item;
    
    NSUInteger numberOfItems = [_items count];
    if (fromIndex >= numberOfItems)
    return;
    
    NSMutableArray *items = [_items mutableCopy];

    
    [items removeObjectAtIndex:fromIndex];
    [items insertObject:item atIndex:fromIndex];
    
    _items = items;
}

- (NSArray *)indexPathsForItem:(id)item
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger objectIndex, BOOL *stop) {
        if ([obj isEqual:item])
            [indexPaths addObject:[NSIndexPath indexPathForItem:objectIndex inSection:0]];
    }];
    return indexPaths;
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath) {
        return;
    }
    
    NSIndexSet *removedIndexes = [NSIndexSet indexSetWithIndex:indexPath.item];
    [self removeItemsAtIndexes:removedIndexes];
}

- (void)removeItemsAtIndexes:(NSIndexSet *)indexes
{
    NSInteger newCount = [_items count] - [indexes count];
    NSMutableArray *newItems = newCount > 0 ? [[NSMutableArray alloc] initWithCapacity:newCount] : nil;
    
    // set up a delayed set of batch update calls for later execution
    __block dispatch_block_t batchUpdates = ^{};
    batchUpdates = [batchUpdates copy];
    
    [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        dispatch_block_t oldUpdates = batchUpdates;
        if ([indexes containsIndex:idx]) {
            // we're removing this item
            batchUpdates = ^{
                oldUpdates();
            };
        }
        else {
            // we're keeping this item
            [newItems addObject:obj];
            batchUpdates = ^{
                oldUpdates();
            };
        }
        batchUpdates = [batchUpdates copy];
    }];
    
    _items = newItems;
    batchUpdates();
}

- (void) addItems:(NSArray *)newItems
{
    NSMutableArray *oldItems = [NSMutableArray arrayWithArray:self.items];
    [oldItems addObjectsFromArray:newItems];
    [self setItems:oldItems];
}

- (void)setItems:(NSArray *)items
{
    if (_items == items || [_items isEqualToArray:items])
        return;

    NSOrderedSet *oldItemSet = [NSOrderedSet orderedSetWithArray:_items];
    NSOrderedSet *newItemSet = [NSOrderedSet orderedSetWithArray:items];
    
    NSMutableOrderedSet *deletedItems = [oldItemSet mutableCopy];
    [deletedItems minusOrderedSet:newItemSet];
    
    NSMutableOrderedSet *newItems = [newItemSet mutableCopy];
    [newItems minusOrderedSet:oldItemSet];
    
    NSMutableOrderedSet *movedItems = [newItemSet mutableCopy];
    [movedItems intersectOrderedSet:oldItemSet];
    
    NSMutableArray *deletedIndexPaths = [NSMutableArray arrayWithCapacity:[deletedItems count]];
    for (id deletedItem in deletedItems) {
        [deletedIndexPaths addObject:[NSIndexPath indexPathForItem:[oldItemSet indexOfObject:deletedItem] inSection:0]];
    }
    
    NSMutableArray *insertedIndexPaths = [NSMutableArray arrayWithCapacity:[newItems count]];
    for (id newItem in newItems) {
        [insertedIndexPaths addObject:[NSIndexPath indexPathForItem:[newItemSet indexOfObject:newItem] inSection:0]];
    }
    
    NSMutableArray *fromMovedIndexPaths = [NSMutableArray arrayWithCapacity:[movedItems count]];
    NSMutableArray *toMovedIndexPaths = [NSMutableArray arrayWithCapacity:[movedItems count]];
    for (id movedItem in movedItems) {
        [fromMovedIndexPaths addObject:[NSIndexPath indexPathForItem:[oldItemSet indexOfObject:movedItem] inSection:0]];
        [toMovedIndexPaths addObject:[NSIndexPath indexPathForItem:[newItemSet indexOfObject:movedItem] inSection:0]];
    }
    
    _items = [items copy];
}

- (NSUInteger)countOfItems
{
    return [_items count];
}

@end
