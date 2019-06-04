public without sharing class AdminController {
    @AuraEnabled
    public static List<Object> getUserIndicators() {
        // TODO - used for interactive tab displaying users online;
        return null;
    }

    @AuraEnabled
    public static void deactivateUser(AppUser__x appUser) {
        AppUser__x userToUpdate = appUser.clone(false, true);
        userToUpdate.Active__c = false;
        updateUserInfo(userToUpdate);
    }

    @AuraEnabled
    public static void reactivateUser(AppUser__x appUser) {
        AppUser__x userToUpdate = appUser.clone(false, true);
        userToUpdate.Active__c = true;
        updateUserInfo(userToUpdate);
    }

    @AuraEnabled
    public static void deleteUser(AppUser__x appUser) {
        try {
            AdminService.getInstance().deleteUser(appUser);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    private static void updateUserInfo(AppUser__x appUser) {
        try {
            AdminService.getInstance().updateUser(appUser);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}