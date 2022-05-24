@AbapCatalog.sqlViewName: '/DF5/IMMBPSUPPLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Supplier Company Code'
define view /DF5/I_MM_BUSPART_SUPPL_CO
  as select from I_SupplierCompany
  association [1..1] to I_Supplier_to_BusinessPartner  as _SupplierToBusinessPartner on  $projection.Supplier = _SupplierToBusinessPartner.Supplier
  association [1..1] to I_CompanyCode                  as _CompanyCode               on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_SupplierCompany              as _SupplierCompany           on  $projection.CompanyCode = _SupplierCompany.CompanyCode
                                                                                     and $projection.Supplier    = _SupplierCompany.Supplier
  //Association added for text annotation removal
  association [0..1] to I_PaymentBlockingReason     as _PaytBlkgRsnValueHelp      on  $projection.PaymentBlockingReason = _PaytBlkgRsnValueHelp.PaymentBlockingReason
  association [0..*] to I_PaymentBlockingReasonText as _PaymentBlockingReasonText on  $projection.PaymentBlockingReason = _PaymentBlockingReasonText.PaymentBlockingReason
{

  key  _SupplierToBusinessPartner._BusinessPartner.BusinessPartner,
  key  CompanyCode,
       Supplier,
       _SupplierToBusinessPartner.BusinessPartnerUUID,
       SupplierIsBlockedForPosting,
       AuthorizationGroup,
       AccountingClerk,
       SupplierClerk,
       AccountingClerkPhoneNumber,
       AccountingClerkFaxNumber,
       AccountingClerkInternetAddress,
       SupplierClerkIDBySupplier,
       IsToBeLocallyProcessed,
       SupplierAccountNote,
       PaymentTerms,
       APARToleranceGroup,
       SuplrInvcVerificatTolGroup,
       CheckPaidDurationInDays,
       IsDoubleInvoice,
       CustomerSupplierClearingIsUsed,
       ReconciliationAccount,
       SupplierHeadOffice,
       LayoutSortingRule,
       SupplierCertificationDate,
       PaymentMethodsList,
       CashPlanningGroup,
       @ObjectModel.foreignKey.association: '_PaytBlkgRsnValueHelp'
       @ObjectModel.text.association: '_PaymentBlockingReasonText'
       PaymentBlockingReason,
       AlternativePayee, //lnrzb
       HouseBank,
       @Semantics.amount.currencyCode: 'Currency'
       BillOfExchLmtAmtInCoCodeCrcy,
       ItemIsToBePaidSeparately,
       PaymentIsToBeSentByEDI,
       WithholdingTaxCountry,
       InterestCalculationCode,
       InterestCalculationDate,
       IntrstCalcFrequencyInMonths,
       LastInterestCalcRunDate,
       _CompanyCode.Country                            as Country,
       //for extensibility
       cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity,
       //added for DCL
       IsBusinessPurposeCompleted,
       @Semantics.currencyCode: true
       _CompanyCode.Currency                           as Currency,
       MinorityGroup,
       _SupplierToBusinessPartner,
       _CompanyCode,
       _PaytBlkgRsnValueHelp,
       _PaymentBlockingReasonText
}
