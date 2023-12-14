@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Confirmations line item'
define view entity /DF5/I_POCONF_ITEMS
  as select from /DF5/I_EKPO as PurchaseOrderItem

  association [1]    to /DF5/I_EKKO            as _PurchaseOrder       on  PurchaseOrderItem.Ebeln = _PurchaseOrder.Ebeln

  association [0..*] to /DF5/I_EKES            as _ekes                on  PurchaseOrderItem.Ebeln = _ekes.Ebeln
                                                                       and PurchaseOrderItem.Ebelp = _ekes.Ebelp
                                                                       and _ekes.Ebtyp             = 'AB'

  association [1..1] to /DF5/I_EKET_DELDATEQTY as _eket                on  PurchaseOrderItem.Ebeln = _eket.PurchaseOrder
                                                                       and PurchaseOrderItem.Ebelp = _eket.PurchaseOrderLine

  association [0..1] to I_Product              as _Product             on  PurchaseOrderItem.Matnr = _Product.Product

  association [0..1] to /DF5/I_T163G           as _ConfirmationControl on  PurchaseOrderItem.Bstae    = _ConfirmationControl.Bstae
                                                                       and _ConfirmationControl.Ebtyp = 'AB'
{
  key PurchaseOrderItem.Ebeln     as PurchaseOrder,
  key PurchaseOrderItem.Ebelp     as PurchaseOrderItem,
  key _ekes.Etens                 as SupplierConfirmation,

      PurchaseOrderItem.Werks     as Plant,
      PurchaseOrderItem.Lgort     as StorageLocation,
      @ObjectModel.text.association: '_Product'
      PurchaseOrderItem.Matnr     as Material,
      PurchaseOrderItem.Matkl     as MaterialClass,
      PurchaseOrderItem.Menge     as RequestedQuantity,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      PurchaseOrderItem.Netpr     as NetPrice,
      PurchaseOrderItem.Meins     as UoM,
      PurchaseOrderItem.Peinh     as PriceUnit,
      PurchaseOrderItem.Bprme     as OrderPriceUnit,
      PurchaseOrderItem.Repos     as InvoiceReceiptIndicator,
      PurchaseOrderItem.Afnam     as Requisitioner,
      PurchaseOrderItem.Repos     as InvoiceIsExpected,
      PurchaseOrderItem.Idnlf     as SupplierMaterialNumber,
      PurchaseOrderItem.Mfrpn     as ManufacturerPartNmbr,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      PurchaseOrderItem.Netwr     as NetAmount,
      _PurchaseOrder.Waers        as DocumentCurrency,

      PurchaseOrderItem.Loekz,
      PurchaseOrderItem.Bstae     as ConfirmationControlKey,
      _ConfirmationControl.Ebtyp  as ConfirmationControlCategory,

      _ekes.Ebeln                 as ekes_ebeln,
      _ekes.Ebelp                 as ekes_ebelp,
      _ekes.Eindt                 as ekes_eindt,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      _ekes.Menge                 as ekes_menge,
      _ekes.Xblnr                 as Reference,
      _ekes.Ebtyp                 as ekes_ebtyp,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      _ekes.Dabmg                 as ReducedQuantity,

      _eket.DelDate               as eket_eindt,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      _eket.Quantity              as eket_menge,
      @Semantics.quantity.unitOfMeasure : 'UoM'
      _eket.QuantityToBeDelivered as QuantityToBeDelivered,

      /* Associations */
      _ekes,
      _eket,
      _Product,
      _ConfirmationControl
}
where
      Loekz                      is initial
  and Bstae                      is not initial
  and _ConfirmationControl.Ebtyp =  'AB'
  and Elikz                      is initial
  and Attyp                      <> '01'
