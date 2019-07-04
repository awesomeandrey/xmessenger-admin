public without sharing class AdminController {
    @AuraEnabled
    public static List<AppUser__x> getUsersOnline() {
        try {
            return AdminService.getInstance().getUsersOnline();
        } catch (Exception ex) {
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

    @AuraEnabled
    public static void resetUserPassword(AppUser__x appUser) {
        try {
            AdminService.getInstance().resetUserPassword(appUser);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}