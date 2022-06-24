@EndUserText.label: 'Confirmation line item projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity /DF5/C_POCONF_LIST
  as projection on /DF5/I_POCONF_LIST
{
      @EndUserText.label: 'Purchase order'
  key PurchaseOrder,
  key PurchaseOrderLine,
      @EndUserText.label: 'Conf. Nr'
  key SupplierConfirmation,
      Plant,
      StorageLocation,
      Supplier,
      @EndUserText.label: 'Vendor name'
      SupplierName,
      PurchOrganisation,
      PurchGroup,
      @EndUserText.label: 'PO Date'
      PODate,
      Material,
      MaterialClass,
      @EndUserText.label: 'Material Descr.'
      _Product._Text.ProductName                                                       : localized,
      @EndUserText.label: 'Requested Quantity'
      RequestedQuantity,
      @EndUserText.label: 'Conf. Qty'
      TotalConfirmed,
      @EndUserText.label: 'Unconf. Qty'
      TotalUnconfirmed,
      @EndUserText.label: 'Next Req. Del. Date'
      NextReqDelDate,
      @EndUserText.label: 'Next Req. Del. Qty.'
      NextRequestedQuantity,
      Reference,
      @EndUserText.label: 'Conf. Del. Date'
      ConfirmedDelDate,
      Quantity,
      @EndUserText.label: 'Net Price'
      NetPrice,
      @EndUserText.label: 'Reduced Qty.'
      ReducedQuantity,
//      @ObjectModel.text.element: ['ConfirmationLineStatusTxt']
//      ConfirmationLinestatus,
 
        @EndUserText.label: 'Conf. Line Status'
      _ConfirmLineStatusText._Text.ConfirmationLineStatusTxt as ConfirmationLinestatus : localized,
      ConfirmLineCriticality,
//      @ObjectModel.text.element: ['LineStatusTxt']
//      ConfirmationStatus,
       @EndUserText.label: 'Line Status'
      _LineStatusText._Text.LineStatusTxt                    as ConfirmationStatus     : localized,
      ConfirmCriticality,
      ActionId,
      UoM,
      Currency,
      Changed,
      TempStoreLoc,
      TempNetPr,

      /* Associations */
      _Header : redirected to parent /DF5/C_POCONF_ID
}
