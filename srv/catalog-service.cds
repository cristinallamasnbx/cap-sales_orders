using com.logali as logali from '../db/schema';

service CatalogServices {
    entity Header as select from logali.Header {
        ID,
        Email @mandatory,
        FirstName,
        LastName,
        Country,
        CreatedOn,
        DeliveryDate,
        OrderStatus,
        ImageUrl,
        ToItems
    };

    @readonly
    entity Item as select from logali.Item {
        ID,
        Name,
        Description,
        ReleaseDate,
        DiscontinuedDate,
        Price,
        Height,
        Width,
        Depth,
        Quantity,
        ToUnitOfMeasure,
        ToHeader
    };

    @readonly
    entity UnitOfMeasure as select from logali.UnitOfMeasure {
        ID,
        Description
    }
}