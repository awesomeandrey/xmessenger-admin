public without sharing class EmailNotificator {
    public static final String EMAIL_PARAM_NAME = 'emailAddress';
    public static final String SUBJECT_PARAM_NAME = 'subject';

    private static final String SENDER_DISPLAY_NAME = 'xMessenger Support Team';

    public static void notify(String templateApiName, Map<String, String> parametersMap) {
        EmailTemplate template = getEmailTemplateByApiName(templateApiName);
        Messaging.SingleEmailMessage emailMessage = composeEmailMessage(template, parametersMap);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                emailMessage
        });
    }

    private static EmailTemplate getEmailTemplateByApiName(String templateApiName) {
        List<EmailTemplate> templatesFound = [
                SELECT Id, Body, HtmlValue
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

    private static Messaging.SingleEmailMessage composeEmailMessage(EmailTemplate template, Map<String, String> parametersMap) {
        if (!parametersMap.containsKey(EMAIL_PARAM_NAME)) {
            throw new NoRecipientEmailException('No email recipient address provided.');
        }
        Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
        emailMessage.setTemplateId(template.Id);
        emailMessage.setSaveAsActivity(true);
        emailMessage.setSubject(parametersMap.containsKey(SUBJECT_PARAM_NAME) ? parametersMap.get(SUBJECT_PARAM_NAME) : 'Support');
        emailMessage.setSenderDisplayName(SENDER_DISPLAY_NAME);
        emailMessage.setToAddresses(new List<String>{
                parametersMap.get(EMAIL_PARAM_NAME)
        });
        emailMessage.setPlainTextBody(fillTemplateValues(template.Body, parametersMap));
        return emailMessage;
    }

    private static String fillTemplateValues(String body, Map<String, String> parametersMap) {
        for (String paramKey : parametersMap.keySet()) {
            body = body.replace('{!' + paramKey + '}', parametersMap.get(paramKey));
        }
        return body;
    }

    class TemplateNotFoundException extends Exception {
    }

    class NoRecipientEmailException extends Exception {
    }
}