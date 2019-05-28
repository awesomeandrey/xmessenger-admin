@IsTest
private class RelatedLinksControllerTest {
    testMethod static void fetchLinks() {
        System.assert(!RelatedLinksController.fetchLinks().isEmpty());
    }
}