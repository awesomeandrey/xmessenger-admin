public class RelatedLinksController {
    @AuraEnabled
    public static List<Link__mdt> fetchLinks() {
        return [
                SELECT Label
                        , Icon__c
                        , URL__c
                FROM Link__mdt
        ];
    }
}