({
    doInit: function (component, event, helper) {
        helper.performAction(component, "c.fetchLinks")
            .then($A.getCallback(links => component.set("v.links", links)));
    }
});