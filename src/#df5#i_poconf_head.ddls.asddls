@AbapCatalog.sqlViewName: '/DF5/IPOCONFHEAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Confirmations header'
define view /DF5/I_POCONF_HEAD
  as select from /DF5/I_EKKO as POHeader

  association [0..*] to /DF5/I_POCONF_ITEMS as _Items    on _Items.PurchaseOrder = $projection.Ebeln
  association [0..1] to I_Supplier          as _Supplier on _Supplier.Supplier = $projection.Supplier
{
  key POHeader.Ebeln,
  key _Items.PurchaseOrderItem,
  key _Items.SupplierConfirmation,
      _Items.PurchaseOrder          as PurchaseOrder,
      POHeader.Lifnr                as Supplier,
      _Supplier.OrganizationBPName1 as SupplierName,
      POHeader.Ekorg                as PurchOrganisation,
      POHeader.Ekgrp                as PurchGroup,
      POHeader.Bedat                as PODate,

      _Items.Material,
      _Items.MaterialClass,
      _Items.RequestedQuantity,
      _Items.Plant,
      _Items.StorageLocation,
      _Items.NetPrice,
      _Items.ekes_ebeln,
      _Items.ekes_ebelp,
      _Items.ekes_eindt,
      _Items.ekes_menge,
      _Items.Reference,
      _Items.ekes_ebtyp,
      _Items.ReducedQuantity,
      _Items.eket_eindt,
      _Items.eket_menge,
      _Items.UoM,
      _Items.PriceUnit,
      _Items.OrderPriceUnit,
      _Items.ConfirmationControlKey,
      _Items.ConfirmationControlCategory,
      POHeader.Waers                as Currency,
      /* Associations */
      _Items,
      _Supplier,
      _Items._Product
}
where
      POHeader.Loekz  =  ''
  and POHeader.Memory =  ''
  and POHeader.Frgrl  =  ''
  and POHeader.Autlf  <> 'X'
  and POHeader.Bstyp  = 'F'
  
