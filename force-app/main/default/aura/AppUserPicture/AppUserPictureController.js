({
    doInit: function (component, event, helper) {
        helper.performAction(component, "c.getApiServerUrl")
            .then($A.getCallback(link => component.set("v._apiServerUrl", link)));
    }
});