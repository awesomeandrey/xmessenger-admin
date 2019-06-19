@IsTest
private class MetadataHolderTest {
    @IsTest
    static void getCustomMetadataType() {
        String customMetadataTypeDevName = 'API_server';
        MetadataHolder metadataHolder = MetadataHolder.getInstance();
        Link__mdt apiServerLink = (Link__mdt) metadataHolder.get(Link__mdt.getSObjectType(), customMetadataTypeDevName);
        System.assertEquals(customMetadataTypeDevName, apiServerLink.DeveloperName);
    }

    @IsTest
    static void getCustomMetadataType_Error() {
        String customMetadataTypeDevName = 'unknown_md_type';
        MetadataHolder metadataHolder = MetadataHolder.getInstance();
        try {
            metadataHolder.get(Link__mdt.getSObjectType(), customMetadataTypeDevName);
        } catch (SObjectException ex) {
            System.assert(true);
        }
    }
}