({
    deactivateUser: function (component, event, helper) {
        helper.toggleComponentState(component);
        const appUser = component.get("v._appUser");

        debugger;

        appUser.User_Id__c = 520;

        helper.performAction(component, "c.deactivateUser", null)
            .then($A.getCallback(response => {
                debugger;
            }));
    }
});