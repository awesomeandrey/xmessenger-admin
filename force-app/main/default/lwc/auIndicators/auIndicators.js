import {LightningElement, track} from "lwc";

export default class AuIndicators extends LightningElement {
    @track appUsers = [];
    @track loading = false;

    handleRefreshIndicators() {
        debugger;
        this.loading = true;
        setTimeout(_ => {
            this.loading = false;
            this.appUsers = [
                {
                    Id: "x001x0000008Ry9AAE",
                    Fullname__c: "Test",
                    Username__c: "test",
                },
                {
                    Id: "x001x0000008Ry9AAE",
                    Fullname__c: "Test",
                    Username__c: "test",
                }, {
                    Id: "x001x0000008Ry9AAE",
                    Fullname__c: "Test",
                    Username__c: "test",
                }
            ];
        }, 2500);
    }

    connectedCallback() {
        this.handleRefreshIndicators();
    }
}