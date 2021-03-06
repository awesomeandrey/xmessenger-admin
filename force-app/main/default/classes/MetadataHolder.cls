public inherited sharing class MetadataHolder {
    private final Set<String> EXCLUDED_SYSTEM_FIELDS = new Set<String>{
            'Id', 'MasterLabel', 'Language', 'NamespacePrefix', 'QualifiedApiName'
    };

    private MetadataHolder() {
    }

    public static MetadataHolder getInstance() {
        return new MetadataHolder();
    }

    public SObject get(SObjectType sObjectType, String devName) {
        List<SObject> result = this.get(sObjectType, new Set<String>{
                devName
        });
        return result.isEmpty() ? null : result[0];
    }

    public List<SObject> get(SObjectType sObjectType, Set<String> devNames) {
        List<SObject> result = new List<SObject>(), metadataTypesAll = this.getAll(sObjectType);
        String devName = null;
        for (SObject sobjectToCheck : metadataTypesAll) {
            devName = (String) sobjectToCheck.get('DeveloperName');
            if (devNames.contains(devName)) {
                result.add(sobjectToCheck);
            }
        }
        return result;
    }

    public List<SObject> getAll(SObjectType sObjectType) {
        if (!this.isCustomMetadataType(sObjectType)) {
            throw new SObjectException('Provided sobject type is not of custom metadata type.');
        }
        String queryAllStr = this.buildQuery(sObjectType);
        return Database.query(queryAllStr);
    }

    private Boolean isCustomMetadataType(SObjectType sObjectType) {
        String objectDevName = sObjectType.getDescribe().getName();
        return objectDevName.endsWith('__mdt');
    }

    private String buildQuery(SObjectType sObjectType) {
        List<SObjectField> fieldsList = sObjectType.getDescribe().fields.getMap().values();
        Set<SObjectField> filteredFields = this.filterFieldsList(fieldsList);
        return String.format('SELECT {0} FROM {1}', new List<String>{
                this.composeFieldsQuery(filteredFields), sObjectType.getDescribe().getName()
        });
    }

    private Set<SObjectField> filterFieldsList(List<SObjectField> fieldsList) {
        Set<SObjectField> filteredFields = new Set<SObjectField>();
        String fieldName = null;
        for (SObjectField fieldItem : fieldsList) {
            fieldName = fieldItem.getDescribe().getName();
            if (!this.EXCLUDED_SYSTEM_FIELDS.contains(fieldName)) {
                filteredFields.add(fieldItem);
            }
        }
        return filteredFields;
    }

    private String composeFieldsQuery(Set<SObjectField> fieldsList) {
        List<String> fieldNames = new List<String>();
        for (SObjectField fieldDetails : fieldsList) {
            fieldNames.add(fieldDetails.getDescribe().getName());
        }
        return String.join(fieldNames, ',');
    }
}