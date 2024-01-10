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
        Items
    };

    @readonly
    entity Item as select from logali.Item {
        ID,
        Name,
        Description,
        ReleaseDate,
        DiscontinuedDate,
        Price,
        Header as ToHeader
    }
}