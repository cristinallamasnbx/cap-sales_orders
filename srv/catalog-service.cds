using com.logali as logali from '../db/schema';

service CatalogServices {
    entity Header @(
        Capabilities.Insertable: true,
        Capabilities.Updatable: true
    ) as select from logali.Header {
        ID,
        Email @mandatory,
        FirstName @mandatory,
        LastName @mandatory,
        Country @mandatory,
        CreatedOn @mandatory,
        DeliveryDate @mandatory,
        OrderStatus @mandatory,
        ImageUrl,
        ToItems
    };

    @readonly
    entity HeaderxItem as select from logali.HeaderxItem {
        ID,
        Header,
        Item
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

    @readonly
    entity ItemxUnitOfMeasure as select from logali.ItemxUnitOfMeasure {
        ID,
        Item,
        UnitOfMeasure
    }
}