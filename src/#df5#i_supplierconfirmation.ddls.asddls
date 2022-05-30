@AbapCatalog.sqlViewName: '/DF5/ISUPPLCONF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Supplier Confirmations'
define root view /DF5/I_SUPPLIERCONFIRMATION
  as select from /DF5/I_EKES
  association to /DF5/I_EKPO as _ekpo on  $projection.PurchaseOrder     = _ekpo.Ebeln
                                      and $projection.PurchaseOrderLine = _ekpo.Ebelp
{
  key Ebeln       as PurchaseOrder,
  key Ebelp       as PurchaseOrderLine,
  key Etens       as SupplierConfirmation,
      Ebtyp       as ConfirmationCategory,
      Eindt       as ConfirmedDelDate,
      @Semantics.quantity.unitOfMeasure: 'UoM'
      Menge       as Quantity,
      _ekpo.Meins as UoM,
      Xblnr       as Reference,
      Ematn       as Product,

      /* Associations */
      _ekpo

}
where
  Ebtyp = 'AB'
