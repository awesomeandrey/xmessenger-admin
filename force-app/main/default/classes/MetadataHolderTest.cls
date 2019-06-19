@IsTest
private class MetadataHolderTest {
    @IsTest
    static void getCustomMetadataType() {
        String customMetadataTypeDevName = 'API_server';
        MetadataHolder metadataHolder = MetadataHolder.getInstance();
        Link__mdt apiServerLink = (Link__mdt) metadataHolder.get(Link__mdt.getSObjectType(), customMetadataTypeDevName);
        System.assertEquals(customMetadataTypeDevName, apiServerLink.DeveloperName);
        SObject result = metadataHolder.get(Link__mdt.getSObjectType(), 'unknown_custom_md_type');
        System.assertEquals(null, result);
    }

    @IsTest
    static void getCustomMetadataType_Error() {
        MetadataHolder metadataHolder = MetadataHolder.getInstance();
        try {
            metadataHolder.getAll(Account.getSObjectType());
            System.assertEquals(1, 2); // explicit test failure;
        } catch (SObjectException ex) {
            System.assert(true);
        }
    }
}