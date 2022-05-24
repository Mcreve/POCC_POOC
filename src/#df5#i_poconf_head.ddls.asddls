@AbapCatalog.sqlViewName: '/DF5/IPOCONFHEAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Confirmations header'
define view /DF5/I_POCONF_HEAD
  as select from ekko as POHeader

  association [1..1] to /DF5/I_POCONF_ITEMS as _Items    on _Items.PurchaseOrder = POHeader.ebeln
  association [0..1] to I_Supplier          as _Supplier on _Supplier.Supplier = POHeader.lifnr
{
  key POHeader.ebeln,
  key _Items.PurchaseOrderItem,
  key _Items.SupplierConfirmation,
      _Items.PurchaseOrder as PurchaseOrder,
      POHeader.lifnr                as Supplier,
      _Supplier.OrganizationBPName1 as SupplierName,
      POHeader.ekorg                as PurchOrganisation,
      POHeader.ekgrp                as PurchGroup,
      POHeader.bedat                as PODate,

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
      POHeader.waers                as Currency,
      
      /* Associations */
      _Items,
      _Supplier,
      _Items._Product
}
where
      POHeader.loekz  =  ''
  and POHeader.memory =  ''
  and POHeader.frgrl  =  ''
  and POHeader.autlf  <> 'X'
  and _Items.PurchaseOrderItem != '00000'
