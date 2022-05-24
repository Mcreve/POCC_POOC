@AbapCatalog.sqlViewName: '/DF5/IEKES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Supplier Confirmations'
define root view /DF5/I_EKES
  as select from ekes
  association to ekpo as _ekpo on  _ekpo.ebeln = ekes.ebeln
                               and _ekpo.ebelp = ekes.ebelp
{
  key ebeln       as PurchaseOrder,
  key ebelp       as PurchaseOrderLine,
  key etens       as SupplierConfirmation,
      ebtyp       as ConfirmationCategory,
      eindt       as ConfirmedDelDate,
      @Semantics.quantity.unitOfMeasure: 'UoM'
      menge       as Quantity,
      _ekpo.meins as UoM,
      xblnr       as Reference,
      ematn       as Material,

      /* Associations */
      _ekpo

}
where
  ebtyp = 'AB'
