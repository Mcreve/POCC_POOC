@AbapCatalog.sqlViewName: '/DF5/IPOCONFLIST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface for PO Confirmation List view'
define view /DF5/I_POCONF_LIST
  as select from /DF5/I_POCONF_UNION as Orders
  association [1]    to /DF5/I_LINESTATUS            as _LineStatusText               on  $projection.ConfirmationStatus = _LineStatusText.LineStatus
  association [1]    to /DF5/I_CONFIRMLINESTATUS     as _ConfirmLineStatusText        on  $projection.ConfirmationLinestatus = _ConfirmLineStatusText.ConfirmationLineStatus

  association        to parent /DF5/I_POCONF_ID      as _Header                       on  _Header.purchaseorder = $projection.PurchaseOrder
                                                                                      and _Header.actionid      = $projection.ActionId
  association [0..1] to /DF5/I_MM_PURCHASINGORG_VH   as _/DF5/I_MM_PURCHASINGORG_VH   on  Orders.PurchOrganisation = _/DF5/I_MM_PURCHASINGORG_VH.PurchasingOrganization
//  association [0..1] to /DF5/I_PLANTPURCHASINGORG_VH as _/DF5/I_PLANTPURCHASINGORG_VH on  Orders.Plant = _/DF5/I_PLANTPURCHASINGORG_VH.Plant
  association [0..1] to /DF5/I_MM_SMPLSUPPLIER_VH    as _/DF5/I_MM_SMPLSUPPLIER_VH    on  Orders.Supplier = _/DF5/I_MM_SMPLSUPPLIER_VH.Supplier
//  association [0..1] to /DF5/I_PRODUCTGROUP_2_VH     as _/DF5/I_PRODUCTGROUP_2_VH     on  Orders.MaterialClass = _/DF5/I_PRODUCTGROUP_2_VH.ProductGroup
//  association [0..1] to /DF5/I_MM_PRODUCT_VH         as _/DF5/I_MM_PRODUCT_VH         on  Orders.Material = _/DF5/I_MM_PRODUCT_VH.Product
  association [0..1] to /DF5/I_MM_PURCHASINGGROUP_VH as _/DF5/I_MM_PURCHASINGGROUP_VH on  Orders.PurchGroup = _/DF5/I_MM_PURCHASINGGROUP_VH.PurchasingGroup
{
      //Orders
  key PurchaseOrder,
  key PurchaseOrderItem               as PurchaseOrderLine,
  key SupplierConfirmation,
      Plant,
      StorageLocation,
      Supplier,
      SupplierName,
      PurchOrganisation,
      PurchGroup,
      PODate,
      Material,
      MaterialClass,
      RequestedQuantity,
      TotalConfirmed,
      TotalUnconfirmed,
      NextReqDelDate,
      NextRequestedQuantity,
      Reference,
      ConfirmedDelDate,
      Quantity,
      NetPrice,
      ReducedQuantity,
//      @ObjectModel.text.association: '_ConfirmLineStatusText'
      ConfirmationLinestatus,
      _ConfirmLineStatusText,
      case ConfirmationLinestatus
        when 'O' then 0
        when 'C' then 3
        else 1
      end                             as ConfirmLineCriticality,
//      @ObjectModel.text.association: '_ConfirmStatusText'
      ConfirmationStatus,
      case ConfirmationStatus
        when 'U' then 0
        when 'P' then 0
        when 'F' then 3
        else 1
      end                             as ConfirmCriticality,
      _LineStatusText,
      ActionId,
      UoM,
      Currency,
      ''                              as Changed,
      cast('None' as abap.char( 10 )) as TempStoreLoc,
      cast('None' as abap.char( 10 )) as TempNetPr,

      /* Associations */
      _Items,
      _Supplier,
      _Product,
      _Header,
      _/DF5/I_MM_PURCHASINGORG_VH,
//      _/DF5/I_PLANTPURCHASINGORG_VH,
      _/DF5/I_MM_SMPLSUPPLIER_VH,
//      _/DF5/I_PRODUCTGROUP_2_VH,
//      _/DF5/I_MM_PRODUCT_VH,
      _/DF5/I_MM_PURCHASINGGROUP_VH

}
