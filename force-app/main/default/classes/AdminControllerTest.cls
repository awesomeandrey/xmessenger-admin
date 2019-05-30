@IsTest
private class AdminControllerTest {
    private final static Integer SC_OK = 200;
    private final static Integer SC_BAD_REQUEST = 400;

    testMethod static void deactivateUser() {
        AppUser__x appUser = composeAppUser();
        Test.setMock(HttpCalloutMock.class, new TestRequest(SC_OK));
        HttpResponse response = (HttpResponse) AdminController.deactivateUser(appUser);
        System.assertEquals(SC_OK, response.getStatusCode());
        Test.setMock(HttpCalloutMock.class, new TestRequest(SC_BAD_REQUEST));
        response = (HttpResponse) AdminController.deactivateUser(appUser);
        System.assertEquals(SC_BAD_REQUEST, response.getStatusCode());
    }

    private static AppUser__x composeAppUser() {
        String userId = '1234';
        AppUser__x appUser = new AppUser__x();
        appUser.ExternalId = userId;
        appUser.User_Id__c = Integer.valueOf(userId);
        appUser.Fullname__c = 'Test App User';
        appUser.Username__c = 'test';
        return appUser;
    }

    public class TestRequest implements HttpCalloutMock {
        private Integer statusCode;

        private TestRequest(Integer statusCode) {
            this.statusCode = statusCode;
        }

        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(this.statusCode);
            return res;
        }
    }
}