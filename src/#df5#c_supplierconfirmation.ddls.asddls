@EndUserText.label: 'Supplier Confirmations projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity /DF5/C_SUPPLIERCONFIRMATION
  provider contract transactional_query
  as projection on /DF5/I_SUPPLIERCONFIRMATION
{
  key PurchaseOrder,
  key PurchaseOrderLine,
  key SupplierConfirmation,
      ConfirmationCategory,
      ConfirmedDelDate,
      Quantity,
      UoM,
      Reference,
      Product,
      
      /* Associations */
      _ekpo
}
