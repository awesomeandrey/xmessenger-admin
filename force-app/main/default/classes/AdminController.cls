public class AdminController {
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
    public static void activateUser(AppUser__x appUser) {
        AppUser__x userToUpdate = appUser.clone(false, true);
        userToUpdate.Active__c = true;
        updateUserInfo(userToUpdate);
    }

    @AuraEnabled
    public static Object deleteUser() {
        // TODO - use Continuation;
        return null;
    }

    private static void updateUserInfo(AppUser__x appUser) {
        try {
            AdminService.getInstance().updateUser(appUser);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}