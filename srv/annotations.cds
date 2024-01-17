using {CatalogServices as service} from './catalog-service.cds';

annotate service.Header with {
    OrderStatus @title: 'Status';
    LastName    @title: 'Surname';
    CreatedOn   @title: 'Created on';
    Email       @title: 'Email';
}

@odata.draft.enabled
annotate service.Header with @(
    Capabilities.Insertable: true,
    Capabilities.Updatable : true,
    UI.CreateHidden        : false,
    UI.UpdateHidden        : false,
    // SemanticKey
    Common.SemanticKey     : [ID],

    // Filters
    UI.SelectionFields     : [
        Email,
        LastName
    ],

    // Header
    UI.HeaderInfo          : {
        $Type         : '',
        TypeName      : 'Sales Order',
        TypeNamePlural: 'Sales Orders',
        Title         : {
            $Type: 'UI.DataField',
            Value: Email,
        },
        Description   : {
            $Type: 'UI.DataField',
            /*Value: {$edmJson: {
                $Apply   : [
                    {Path: 'FirstName'},
                    ' ',
                    {Path: 'LastName'}
                ],
                $Function: 'odata.concat'
            }}*/
            Value: CreatedOn
        },
        ImageUrl      : ImageUrl
    },

    // Table sort order
    UI.PresentationVariant : {
        SortOrder     : [
                         //Default sort order
                        {Property: CreatedOn}, ],
        Visualizations: ['@UI.LineItem'],
    },

    // Table
    UI.LineItem            : [
        {
            $Type: 'UI.DataField',
            Value: CreatedOn,
            Label: 'Date'
        },
        {
            $Type: 'UI.DataField',
            Value: OrderStatus,
            Label: 'Status'
        },
        {
            $Type: 'UI.DataField',
            Value: FirstName,
            Label: 'Name'
        },
        {
            $Type: 'UI.DataField',
            Value: LastName,
            Label: 'Surname'
        },
        {
            $Type: 'UI.DataField',
            Value: Email
        },
        {
            $Type: 'UI.DataField',
            Value: Country
        },
        {
            $Type: 'UI.DataField',
            Value: DeliveryDate,
            Label: 'Estimated delivery'
        },
    ],

    // Facets
    UI.FieldGroup #GroupA  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: FirstName,
                Label: 'Name'
            },
            {
                $Type: 'UI.DataField',
                Value: LastName,
                Label: 'Surname'
            },
            {
                $Type: 'UI.DataField',
                Value: Email,
                Label: 'Email'
            },
            {
                $Type: 'UI.DataField',
                Value: ImageUrl,
                Label: 'Company Logo'
            }
        ]
    },
    UI.FieldGroup #GroupB  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ID,
                Label: 'Sales Order ID'
            },
            {
                $Type: 'UI.DataField',
                Value: CreatedOn,
                Label: 'Created on'
            },
            {
                $Type: 'UI.DataField',
                Value: OrderStatus,
                Label: 'Status'
            },
            {
                $Type: 'UI.DataField',
                Value: DeliveryDate,
                Label: 'Estimated delivery date'
            },
            {
                $Type: 'UI.DataField',
                Value: Country,
                Label: 'Country'
            }
        ]
    },
    UI.Facets              : [
        /*{
            $Type : 'UI.CollectionFacet',
            Facets: [{
                $Type : 'UI.ReferenceFacet',
                Target: ![@UI.FieldGroup#GroupA],
                Label : 'Sales Order Information'
            }],
        },*/
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Client information',
            Target: ![@UI.FieldGroup#GroupA]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Sales order information',
            Target: ![@UI.FieldGroup#GroupB]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Sales order items',
            Target: 'ToItems/@UI.LineItem'
        }
    ]
);

annotate service.Item with @(
    // Table sort order
    UI.PresentationVariant: {
        SortOrder     : [ //Default sort order
        {
            Property  : Price,
            Descending: true,
        }, ],
        Visualizations: ['@UI.LineItem'],
    },

    // Header
    UI.HeaderInfo         : {
        $Type         : '',
        TypeName      : 'Item',
        TypeNamePlural: 'Items',
        Title         : {
            $Type: 'UI.DataField',
            Value: Name,
            Label: 'Name'
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: Description,
            Label: 'Description'
        }
    },

    // Table
    UI.LineItem           : [
        {
            $Type: 'UI.DataField',
            Value: Name,
            Label: 'Name'
        },
        {
            $Type: 'UI.DataField',
            Value: Description,
            Label: 'Description'
        },
        {
            $Type: 'UI.DataField',
            Value: Price,
            Label: 'Price'
        },
        {
            $Type: 'UI.DataField',
            Value: Quantity,
            Label: 'Quantity'
        },
        {
            $Type: 'UI.DataField',
            Value: ToUnitOfMeasure.Description,
            Label: 'Unit'
        }
    ],

    // Facets
    UI.FieldGroup #GroupA : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ReleaseDate,
                Label: 'Release date'
            },
            {
                $Type: 'UI.DataField',
                Value: DiscontinuedDate,
                Label: 'Discontinued date'
            },
            {
                $Type: 'UI.DataField',
                Value: Price,
                Label: 'Price'
            }
        ]
    },
    UI.FieldGroup #GroupB : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Height,
                Label: 'Height'
            },
            {
                $Type: 'UI.DataField',
                Value: Width,
                Label: 'Width'
            },
            {
                $Type: 'UI.DataField',
                Value: Depth,
                Label: 'Depth'
            },
            {
                $Type: 'UI.DataField',
                Value: Quantity,
                Label: 'Quantity'
            },
            {
                $Type: 'UI.DataField',
                Value: ToUnitOfMeasure_ID,
                Label: 'Unit of measure'
            }
        ]
    },
    UI.Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Product information',
            Target: ![@UI.FieldGroup#GroupA]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Technical information',
            Target: ![@UI.FieldGroup#GroupB]
        }
    ]
);
