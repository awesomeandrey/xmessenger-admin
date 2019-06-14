import {LightningElement, api} from "lwc";

export default class AuIndicator extends LightningElement {
    @api appUser = {};

    handleNavigateToRecord() {
        console.log(JSON.stringify(this.appUser));
        debugger;
    }

    connectedCallback() {
        debugger;
    }
}