public without sharing class EmailNotificator {
    public static final String EMAIL_PARAM_NAME = 'emailAddress';

    public static void notify(String templateApiName) {
    }

    public static void notify(String templateApiName, Map<String, String> parametersMap) {
        if (!parametersMap.containsKey(EMAIL_PARAM_NAME)) {
            throw new NoRecipientEmailException('No email recipient address provided.');
        }
        String recipientEmailAddress = parametersMap.get(EMAIL_PARAM_NAME);
        EmailTemplate template = getEmailTemplateByApiName(templateApiName);
        sendEmail(template, recipientEmailAddress, parametersMap);
    }

    private static EmailTemplate getEmailTemplateByApiName(String templateApiName) {
        List<EmailTemplate> templatesFound = [
                SELECT Id, Body
                FROM EmailTemplate
                WHERE DeveloperName = :templateApiName
                LIMIT 1
        ];
        if (templatesFound.isEmpty()) {
            throw new TemplateNotFoundException(String.format('Template could not be found: [{0}]', new List<String>{
                    templateApiName
            }));
        }
        return templatesFound[0];
    }

    private static void sendEmail(EmailTemplate template, String recipientEmail, Map<String, String> parametersMap) {
        Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
        emailMessage.setTemplateId(template.Id);
        emailMessage.setToAddresses(new List<String>{
                recipientEmail
        });
        String plainText = fillTemplateValues(template, parametersMap);
        emailMessage.setPlainTextBody(plainText);
//        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
//                emailMessage
//        });
    }

    private static String fillTemplateValues(EmailTemplate template, Map<String, String> parametersMap) {
        String result = template.Body;
        for (String paramKey : parametersMap.keySet()) {
            result = result.replace('{!' + paramKey + '}', parametersMap.get(paramKey));
        }
        return result;
    }

    class TemplateNotFoundException extends Exception {
    }

    class NoRecipientEmailException extends Exception {
    }
}