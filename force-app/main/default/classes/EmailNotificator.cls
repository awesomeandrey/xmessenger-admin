public without sharing class EmailNotificator {
    public static void notify(String templateApiName) {
    }

    public static void notify(String templateApiName, AppUser__x appUser) {
    }

    private static EmailTemplate getEmailTemplateByApiName(String templateApiName) {
        return null;
    }

    class TemplateNotFoundException extends Exception {
    }
}