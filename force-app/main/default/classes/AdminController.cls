public class AdminController {
    @AuraEnabled
    public static List<Object> getUserIndicators() {
        // TODO - used for interactive tab displaying users online;
        return null;
    }

    @AuraEnabled
    public static Object deactivateUser(AppUser__x appUser) {
        System.debug('\n\n appUser => ' + appUser + '\n');
//        HttpRequest req = new HttpRequest();
////        req.setEndpoint('callout:API_Server/deactivateUser');
//        req.setEndpoint('http://localhost:8080/admin-api/deactivateUser');
//        req.setMethod('PUT');
//        req.setBody(JSON.serialize(new AppUserWrapper(appUser)));
//        return new Http().send(req);

        return 'hey there';
    }

    @AuraEnabled
    public static Object deleteUser() {
        // TODO - use Continuation;
        return null;
    }

    private class AppUserWrapper {
        private Integer id; // User ID;
        private String username; // Username;

        private AppUserWrapper(AppUser__x appUser) {
            this.id = Integer.valueOf(appUser.User_Id__c);
            this.username = appUser.Username__c;
        }
    }
}