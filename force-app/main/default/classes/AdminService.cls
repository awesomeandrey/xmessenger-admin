public inherited sharing class AdminService extends CalloutExecutor {
    private PropertyMapper mapper;

    private AdminService() {
        this.mapper = new AppUserMapper();
    }

    public static AdminService getInstance() {
        return new AdminService();
    }

    public Boolean updateUser(AppUser__x appUser) {
        super.sendRequest(CalloutConstants.ENDPOINT + '/updateUser', 'PUT', appUser);
        return true;
    }

    public Boolean deleteUser(AppUser__x appUser) {
        super.sendRequest(CalloutConstants.ENDPOINT + '/deleteUser', 'DELETE', appUser);
        return true;
    }

    public Boolean resetUserPassword(AppUser__x appUser) {
        HttpResponse response = super.sendRequest(CalloutConstants.ENDPOINT + '/resetUser', 'PUT', appUser);
        Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        String newRawPassword = (String) payload.get('newPassword');
        EmailNotificator.notify('Reset_Password', new Map<String, String>{
                EmailNotificator.EMAIL_PARAM_NAME => appUser.Email__c,
                'name' => appUser.Name__c,
                'newPassword' => newRawPassword
        });
        return true;
    }

    public List<AppUser__x> getUsersOnline() {
        HttpResponse response = super.sendRequest(CalloutConstants.ENDPOINT + '/indicators');
        List<Indicator> indicators = (List<Indicator>) JSON.deserialize(response.getBody(), List<Indicator>.class);
        Set<Integer> activeUserIds = new Set<Integer>();
        for (Indicator indicatorItem : indicators) {
            activeUserIds.add(indicatorItem.id);
        }
        return [
                SELECT Id
                        , Name__c
                        , Username__c
                FROM AppUser__x
                WHERE User_Id__c IN :activeUserIds
                ORDER BY Last_Login__c DESC
                LIMIT 6
        ];
    }

    protected override String serializeBody(Object body) {
        AppUser__x appUser = (AppUser__x) body;
        Object payload = this.mapper.mapProperties(appUser);
        return super.serializeBody(payload);
    }

    @TestVisible
    private class Indicator {
        public Integer id;
        public Boolean active;
        public String datestamp;

        public Indicator() {
        }
    }
}