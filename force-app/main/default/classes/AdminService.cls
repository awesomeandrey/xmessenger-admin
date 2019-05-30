public inherited sharing class AdminService {
    private final static Set<Integer> SC_FAILURE = new Set<Integer>{
            400 // Bad request;
            , 401 // Unauthorized;
            , 403 // Forbidden;
            , 415 // Unsupported Media type;
            , 500 // Server error;
    };

    private AdminService() {
    }

    public static AdminService getInstance() {
        return new AdminService();
    }

    public Boolean updateUser(AppUser__x appUser) {
        HttpRequest req = this.composeRequest('/updateUser');
        req.setMethod('PUT');
        req.setBody(this.serializeUser(appUser));
        HttpResponse response = new Http().send(req);
        if (SC_FAILURE.contains(response.getStatusCode())) {
            throw new CalloutException(
                    String.format('Callout failure: {0} ({1})', new List<Object>{
                            response.getStatus(), response.getStatusCode()
                    }));
        }
        return true;
    }

    private String serializeUser(AppUser__x appUser) {
        return JSON.serialize(new AppUserWrapper(appUser));
    }

    private HttpRequest composeRequest(String path) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:API_Server' + path);
        req.setTimeout(10000);
        req.setHeader('Content-Type', 'application/json');
        return req;
    }

    private class AppUserWrapper {
        private Integer id; // User_Id__c;
        private String username; // Username__c;
        private Boolean active; // Active__c;

        private AppUserWrapper(AppUser__x appUser) {
            this.id = Integer.valueOf(appUser.User_Id__c);
            this.username = appUser.Username__c;
            this.active = appUser.Active__c;
        }
    }
}