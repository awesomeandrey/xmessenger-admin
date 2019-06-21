public class RelatedLinksController {
    @AuraEnabled(Cacheable=true)
    public static List<Link__mdt> fetchLinks() {
        MetadataHolder metadataHolder = MetadataHolder.getInstance();
        return (List<Link__mdt>) metadataHolder.getAll(Link__mdt.getSObjectType());
    }

    @AuraEnabled(Cacheable=true)
    public static String getApiServerUrl() {
        MetadataHolder metadataHolder = MetadataHolder.getInstance();
        Link__mdt linkItem = (Link__mdt) metadataHolder.get(Link__mdt.getSObjectType(), 'API_server');
        return linkItem == null ? null : linkItem.URL__c;
    }
}