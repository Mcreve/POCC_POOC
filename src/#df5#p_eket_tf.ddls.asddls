@EndUserText.label: 'Calculate nearest date'
define table function /DF5/P_EKET_TF
returns
{
  mandt             : abap.clnt;
  PurchaseOrder     : ebeln;
  PurchaseOrderLine : ebelp;
  Date              : eindt;
}
implemented by method
  /DF5/CL_POCONFIRMATION=>get_eket_info;
