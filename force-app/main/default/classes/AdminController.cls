public without sharing class AdminController {
    @AuraEnabled
    public static List<AppUser__x> getUsersOnline() {
        try {
            return AdminService.getInstance().getUsersOnline();
//            return [
//                    SELECT Id
//                            , Name__c
//                            , Username__c
//                            , Last_Login__c
//                    FROM AppUser__x
//                    ORDER BY Last_Login__c DESC
//                    LIMIT 6
//            ];
        } catch (Exception ex) {
            System.debug('\n\n ex => ' + ex + '\n');
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled
    public static void updateUserInfo(AppUser__x appUser) {
        try {
            AppUser__x userToUpdate = appUser.clone(false, true);
            AdminService.getInstance().updateUser(userToUpdate);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteUser(AppUser__x appUser) {
        try {
            AdminService.getInstance().deleteUser(appUser);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}