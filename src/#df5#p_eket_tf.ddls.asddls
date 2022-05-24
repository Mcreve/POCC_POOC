@EndUserText.label: 'Calculate nearest date'
define table function /DF5/P_EKET_TF
  //with parameters
  //  p_purchaseOrder  : ebeln,
  //  p_purchaseOrderLine  : ebelp
returns
{
  mandt             : abap.clnt;
  PurchaseOrder     : ebeln;
  PurchaseOrderLine : ebelp;
  Date              : eindt;
}
implemented by method
  /DF5/CL_POCONFIRMATION=>get_eket_info;
