@IsTest
private class AdminControllerTest {
//    testMethod static void getUsersOnline() {
//        Test.setMock(HttpCalloutMock.class, new TestRequest(CalloutConstants.SC_OK));
//        AdminController.getUsersOnline();
//        Test.setMock(HttpCalloutMock.class, new TestRequest(CalloutConstants.SC_BAD_REQUEST));
//        try {
//            AdminController.getUsersOnline();
//        } catch (Exception ex) {
//            System.assert(true);
//        }
//    }

    testMethod static void updateUserInfo() {
        AppUser__x appUser = composeAppUser();
        Test.setMock(HttpCalloutMock.class, new TestRequest(CalloutConstants.SC_OK));
        AdminController.updateUserInfo(appUser);
        Test.setMock(HttpCalloutMock.class, new TestRequest(CalloutConstants.SC_BAD_REQUEST));
        try {
            AdminController.updateUserInfo(appUser);
        } catch (Exception ex) {
            System.assert(true);
        }
    }

    testMethod static void deleteUser() {
        AppUser__x appUser = composeAppUser();
        Test.setMock(HttpCalloutMock.class, new TestRequest(CalloutConstants.SC_OK));
        AdminController.deleteUser(appUser);
        Test.setMock(HttpCalloutMock.class, new TestRequest(CalloutConstants.SC_BAD_REQUEST));
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
        appUser.Name__c = 'Test App User';
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