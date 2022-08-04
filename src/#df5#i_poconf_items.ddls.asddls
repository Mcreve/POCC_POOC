@AbapCatalog.sqlViewName: '/DF5/IPOCONFITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Confirmations line item'
define view /DF5/I_POCONF_ITEMS
  as select from /DF5/I_EKPO as PurchaseOrders

  association [0..*] to /DF5/I_EKES            as _ekes    on  PurchaseOrders.Ebeln = _ekes.Ebeln
                                                           and PurchaseOrders.Ebelp = _ekes.Ebelp
                                                           and _ekes.Ebtyp          = 'AB'

  association [1..1] to /DF5/I_EKET_DELDATEQTY as _eket    on  PurchaseOrders.Ebeln = _eket.PurchaseOrder
                                                           and PurchaseOrders.Ebelp = _eket.PurchaseOrderLine

  association [0..1] to I_Product              as _Product on  PurchaseOrders.Matnr = _Product.Product
{
  key PurchaseOrders.Ebeln as PurchaseOrder,
  key PurchaseOrders.Ebelp as PurchaseOrderItem,
  key _ekes.Etens          as SupplierConfirmation,

      PurchaseOrders.Werks as Plant,
      PurchaseOrders.Lgort as StorageLocation,
      @ObjectModel.text.association: '_Product'
      PurchaseOrders.Matnr as Material,
      PurchaseOrders.Matkl as MaterialClass,
      PurchaseOrders.Menge as RequestedQuantity,
      PurchaseOrders.Netpr as NetPrice,
      PurchaseOrders.Meins as UoM,

      PurchaseOrders.Loekz,
      PurchaseOrders.Bstae as ConfirmationControlKey,

      _ekes.Ebeln          as ekes_ebeln,
      _ekes.Ebelp          as ekes_ebelp,
      _ekes.Eindt          as ekes_eindt,
      _ekes.Menge          as ekes_menge,
      _ekes.Xblnr          as Reference,
      _ekes.Ebtyp          as ekes_ebtyp,
      _ekes.Dabmg          as ReducedQuantity,

      _eket.DelDate        as eket_eindt,
      _eket.Quantity       as eket_menge,

      /* Associations */
      _ekes,
      _eket,
      _Product
}
where
      Loekz is initial
  and Bstae is not initial
  and Elikz is initial
  and Attyp <> '01'
