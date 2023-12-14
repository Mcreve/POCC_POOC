@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for PO Confirmation List view'
define view entity /DF5/I_POCONF_LIST
  as select from /DF5/I_POCONF_UNION as Orders
  association [1] to /DF5/I_LINESTATUS        as _LineStatusText        on  $projection.ConfirmationStatus = _LineStatusText.LineStatus
  association [1] to /DF5/I_CONFIRMLINESTATUS as _ConfirmLineStatusText on  $projection.ConfirmationLinestatus = _ConfirmLineStatusText.ConfirmationLineStatus

  association     to parent /DF5/I_POCONF_ID  as _Header                on  _Header.purchaseorder = $projection.PurchaseOrder
                                                                        and _Header.actionid      = $projection.ActionId
{
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
      QuantityToBeDelivered,
      Reference,
      ConfirmedDelDate,
      Quantity,
      NetPrice,
      ReducedQuantity,
      ConfirmationLinestatus,
      _ConfirmLineStatusText,
      case ConfirmationLinestatus
        when 'O' then 0
        when 'C' then 3
        else 1
      end                             as ConfirmLineCriticality,
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
      PriceUnit,
      OrderPriceUnit,
      ConfirmationControlKey,
      ConfirmationControlCategory,
      Currency,
      InvoiceReceiptIndicator,
      POCreator,
      Requisitioner,
      InvoiceIsExpected,
      SupplierMaterialNumber,
      ManufacturerPartNmbr,
      NetAmount,
      ''                              as Changed,
      cast('None' as abap.char( 10 )) as TempStoreLoc,
      cast('None' as abap.char( 10 )) as TempNetPr,

      /* Associations */
      _Items,
      _Supplier,
      _Product,
      _Header
}
