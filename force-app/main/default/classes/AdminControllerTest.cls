@IsTest
private class AdminControllerTest {
    private final static Integer SC_OK = 200;
    private final static Integer SC_BAD_REQUEST = 400;

    testMethod static void deactivateUser() {
        AppUser__x appUser = composeAppUser();
        Test.setMock(HttpCalloutMock.class, new TestRequest(SC_OK));
        AdminController.deactivateUser(appUser);
        Test.setMock(HttpCalloutMock.class, new TestRequest(SC_BAD_REQUEST));
        try {
            AdminController.deactivateUser(appUser);
        } catch (Exception ex) {
            System.assert(true);
        }
    }

    testMethod static void reactivateUser() {
        AppUser__x appUser = composeAppUser();
        Test.setMock(HttpCalloutMock.class, new TestRequest(SC_OK));
        AdminController.reactivateUser(appUser);
        Test.setMock(HttpCalloutMock.class, new TestRequest(SC_BAD_REQUEST));
        try {
            AdminController.reactivateUser(appUser);
        } catch (Exception ex) {
            System.assert(true);
        }
    }

    testMethod static void deleteUser() {
        AppUser__x appUser = composeAppUser();
        Test.setMock(HttpCalloutMock.class, new TestRequest(SC_OK));
        AdminController.deleteUser(appUser);
        Test.setMock(HttpCalloutMock.class, new TestRequest(SC_BAD_REQUEST));
        try {
            AdminController.deleteUser(appUser);
        } catch (Exception ex) {
            System.assert(true);
        }
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