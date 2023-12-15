@AbapCatalog.sqlViewName: '/DF5/IMMSMPSUPVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Simple Supplier Value help'
@Search.searchable: true
@ObjectModel.semanticKey: ['Supplier', 'CompanyCode']
@ObjectModel.representativeKey: 'Supplier'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory:#VALUE_HELP
define root view /DF5/I_MM_SMPLSUPPLIER_VH
  as select from /DF5/I_MM_BP_SUPPLIER_VH
{

      @ObjectModel.text.element:  [ 'SupplierName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH }
  key Supplier,

  key CompanyCode,

      @Semantics.text: true
      SupplierName,

      Country,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      FirstName,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      LastName,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      OrganizationBPName1,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      OrganizationBPName2,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      OrganizationBPName3,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      OrganizationBPName4,

      //for DCL
      @UI.hidden: true
      AuthorizationGroup,
      @UI.hidden: true
      SupplierAccountGroup,
      @UI.hidden: true
      IsBusinessPurposeCompleted,

      _BusinessPartnerSuplrCo

}
