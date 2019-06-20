public inherited sharing class AdminService extends CalloutExecutor {
    private PropertyMapper mapper;

    private AdminService() {
        this.mapper = AppUserMapper.getInstance();
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

    public List<Object> getUsersOnline() {
        // TODO - implement;
        return null;
    }

    protected override String serializeBody(Object body) {
        AppUser__x appUser = (AppUser__x) body;
        Object payload = this.mapper.mapProperties(appUser);
        return super.serializeBody(payload);
    }
}