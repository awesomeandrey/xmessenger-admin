public without sharing class AppUserMapper implements PropertyMapper {
    public Object mapProperties(SObject record) {
        AppUser__x appUser = (AppUser__x) record;
        Map<String, Object> resultMap = new Map<String, Object>{
                'id' => appUser.User_Id__c,
                'username' => appUser.Username__c,
                'active' => appUser.Active__c
        };
        return resultMap;
    }
}