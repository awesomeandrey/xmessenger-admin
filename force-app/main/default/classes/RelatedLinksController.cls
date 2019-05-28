public class RelatedLinksController {
    @AuraEnabled
    public static List<Link__mdt> fetchLinks() {
        return [
                SELECT Label
                        , DeveloperName
                        , Icon__c
                        , URL__c
                FROM Link__mdt
        ];
    }

    @AuraEnabled
    public static String getApiServerUrl() {
        for (Link__mdt linkItem : fetchLinks()) {
            if (linkItem.DeveloperName.equals('API_server')) {
                return linkItem.URL__c;
            }
        }
        return null;
    }
}