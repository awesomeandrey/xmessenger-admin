({
    doInit: function (component, event, helper) {
        component.find("recordLoader").reloadRecord(false, _ => {
            helper.performAction(component, "c.getApiServerUrl")
                .then($A.getCallback(link => {
                    const appUser = component.get("v._appUser"), cacheBreaker = "?t=" + Date.now(),
                        pictureUrl = [link, "open-api/user", appUser["ExternalId"], "picture", cacheBreaker].join("/");
                    component.set("v._pictureUrl", pictureUrl)
                }));
        });
    }
});