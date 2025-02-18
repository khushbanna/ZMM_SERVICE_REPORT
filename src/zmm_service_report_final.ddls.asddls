@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FINAL_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_SERVICE_REPORT_FINAL as select from ZMM_SERVICE_REPORT_CDS

{
         @UI.lineItem             : [{ position: 10 }]
         @EndUserText.label       : 'PurchaseOrder'
         @UI.selectionField       : [{position: 10 }]
   key   PurchaseOrder,
   
         @UI.lineItem             : [{ position: 20 }]
         @EndUserText.label       : 'PurchaseOrderItem'
   key   PurchaseOrderItem,
         
          @UI.lineItem             : [{ position: 30 }]
          @EndUserText.label       : 'OrderQuantity'
           @Aggregation.default: #SUM
         // @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit' 
           cast( OrderQuantity as abap.dec( 23, 2 ) ) as OrderQuantity,
         
          @UI.lineItem             : [{ position: 40 }]
          @EndUserText.label       : 'PurchaseOrderQuantityUnit'
          PurchaseOrderQuantityUnit,
         
          @UI.lineItem             : [{ position: 50 }]
          @EndUserText.label       : 'Plant'
          @UI.selectionField       : [{position: 20 }]
          Plant,
         
          @UI.lineItem             : [{ position: 110 }]
          @EndUserText.label       : 'Miro'
          @UI.selectionField       : [{position: 50 }]
          SupplierInvoice,
          
         
          @UI.lineItem             : [{ position: 120 }]
          @EndUserText.label       : 'Party Invoice No.'
          @UI.selectionField       : [{position: 60 }]
          SupplierInvoiceIDByInvcgParty,
          
         
          @UI.lineItem             : [{ position: 130 }]
          @EndUserText.label       : 'Invoice Status'
          @UI.selectionField       : [{position: 70 }]
          SupplierInvoiceStatus,
          
          @UI.lineItem             : [{ position: 140 }]
          @EndUserText.label       : 'CompanyCodeCurrency'
          CompanyCodeCurrency,
          
          @UI.lineItem             : [{ position: 150 }]
          @EndUserText.label       : 'Invoicevalue'
          @Aggregation.default: #SUM
//          @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
           cast(sum(Invoicevalue ) as abap.dec( 23, 2 ) )as InvoiceValue,
          
          @UI.lineItem             : [{ position: 160 }]
          @EndUserText.label       : 'SupplierName'
          SupplierName,
          
           @UI.lineItem             : [{ position: 170 }]
          @EndUserText.label       : 'Status'
          status,
          
          @UI.lineItem             : [{ position: 180 }]
          @EndUserText.label       : 'Service'
          Service,
          
               @UI.lineItem             : [{ position: 190 }]
          @EndUserText.label       : 'Invoice Posting Date'
          INVOICEPOSINGDATE,
          
      
         @UI.lineItem             : [{ position: 210 }]
         @EndUserText.label       : 'Service Entry Sheet'
         @UI.selectionField       : [{position: 210 }]
         PurchasingHistoryDocument,
           
        @UI.lineItem             : [{ position: 220 }]
        @EndUserText.label       : 'Service Entry Sheet Item'
        @UI.selectionField       : [{position: 220 }]
        PurchasingHistoryDocumentItem ,
          
         @UI.lineItem             : [{ position: 230 }]
         @EndUserText.label       : 'Service Entry Sheet Qty'
         @Aggregation.default: #SUM
       //  @Semantics.quantity.unitOfMeasure:'PurchaseOrderQuantityUnit'
      //   @Aggregation.default: #SUM
       cast( Quantity as abap.dec(23,3) ) as Quantity,
       
        @UI.lineItem             : [{ position: 240 }]
        @EndUserText.label       : 'Serv Date'
        PostingDate,
       
       
        @UI.lineItem             : [{ position: 240 }]
        @EndUserText.label       : 'Material'
        @UI.selectionField       : [{position: 240 }]
        Material,
   
        @UI.lineItem             : [{ position: 250 }]
        @EndUserText.label       : 'PurchasingGroup'
        @UI.selectionField       : [{position: 250 }]
        PurchasingGroup,
        
        @UI.lineItem             : [{ position: 260 }]
        @EndUserText.label       : 'Our Invoice'
        @UI.selectionField       : [{position: 260 }]
        YY1_OurInvoice_PDH,       
        
        @UI.lineItem             : [{ position: 270 }]
        @EndUserText.label       : 'ExchangeRate'
        @UI.selectionField       : [{position: 270 }]
        ExchangeRate,  
       
        @UI.lineItem             : [{ position: 280 }]
        @EndUserText.label       : 'Po Currency'
        @UI.selectionField       : [{position: 280 }]
        Currency, 
        
        @UI.lineItem             : [{ position: 290 }]
        @EndUserText.label       : 'Po Amount'
        @UI.selectionField       : [{position: 290 }]
//        @Semantics.amount.currencyCode: 'CompanyCodeCurrency' 
        PurchaseOrderAmount,
        
        @UI.lineItem             : [{ position: 300 }]  //01-08-2024-ranveer 
        @EndUserText.label       : 'GST Value'
        @UI.selectionField       : [{position: 300 }]
        cast( Gstvalue as abap.dec(13,2) ) as Gstvalue,
         
        @UI.lineItem             : [{ position: 310 }]  //01-08-2024-ranveer
        @EndUserText.label       : 'GST'
        @UI.selectionField       : [{position: 310 }]
        taxcodedescription,

        @UI.lineItem             : [{ position: 320 }]  //01-08-2024-ranveer
        @EndUserText.label       : 'Total Invoice Amount'
        @UI.selectionField       : [{position: 320 }]
        cast( totalinvoiceamount as abap.dec(13,2) ) as totalinvoiceamount 
      


        
}
  group by

PurchaseOrder,
PurchaseOrderItem,
OrderQuantity,
PurchaseOrderQuantityUnit,
Plant,
SupplierInvoice,
SupplierInvoiceIDByInvcgParty,
SupplierInvoiceStatus,
CompanyCodeCurrency,
SupplierName,
status,
Service,
INVOICEPOSINGDATE,
PurchasingHistoryDocument,
PurchasingHistoryDocumentItem,
Quantity,
PostingDate,
Material,
PurchasingGroup,
YY1_OurInvoice_PDH,
ExchangeRate,
Currency,
PurchaseOrderAmount,
Gstvalue, //01-08-2024-ranveer
gstrate,  //01-08-2024-ranveer
taxcodedescription,   //01-08-2024-ranveer
totalinvoiceamount   //01-08-2024-ranveer

