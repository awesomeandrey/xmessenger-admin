@IsTest
private class RelatedLinksControllerTest {
    testMethod static void fetchLinks() {
        System.assert(!RelatedLinksController.fetchLinks().isEmpty());
    }

    testMethod static void getApiServerUrl() {
        System.assertNotEquals(null, RelatedLinksController.getApiServerUrl());
    }
}