using {CatalogServices as service} from './catalog-service.cds'; 

annotate service.Header with @(

);

annotate service.Item with @(
    UI.HeaderInfo         : {
        $Type         : '',
        TypeName      : '',
        TypeNamePlural: '',
    },
    UI.LineItem #Item: [
        {
            $Type: 'UI.DataField',
            Value: Name,
            Label: 'Delivery date'
        },
        {
            $Type: 'UI.DataField',
            Value: Description,
            Label: 'Description'
        },
        {
            $Type: 'UI.DataField',
            Value: Price,
            Label: 'price'
        }
    ]
);