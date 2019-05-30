public class AdminController {

    @AuraEnabled
    public static List<Object> getUserIndicators() {
        // TODO - used for interactive tab displaying users online;
        return null;
    }

    @AuraEnabled
    public static Object deactivateUser(AppUser__x appUser) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:API_Server/deactivateUser');
        req.setMethod('PUT');
        req.setBody(JSON.serialize(appUser));
        return new Http().send(req);
    }

    @AuraEnabled
    public static Object deleteUser() {
        // TODO - use Continuation;
        return null;
    }
}