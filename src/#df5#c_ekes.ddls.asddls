@EndUserText.label: 'Supplier Confirmation projection'
@AccessControl.authorizationCheck: #CHECK
define root view entity /DF5/C_EKES
  provider contract transactional_query
  as projection on /DF5/I_EKES
{
  key PurchaseOrder,
  key PurchaseOrderLine,
  key SupplierConfirmation,
      ConfirmationCategory,
      ConfirmedDelDate,
      Quantity,
      UoM,
      Reference,
      Material,

      /* Associations */
      _ekpo
}
