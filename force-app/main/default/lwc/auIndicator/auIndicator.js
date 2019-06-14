import {LightningElement, api} from "lwc";
import {NavigationMixin} from "lightning/navigation";

export default class AuIndicator extends NavigationMixin(LightningElement) {
    @api appUser = {};

    handleNavigateToRecord(event) {
        event.preventDefault();
        event.stopPropagation();
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                recordId: this.appUser.Id,
                objectApiName: "AppUser__x",
                actionName: "view"
            }
        });
    }

    connectedCallback() {
        this.addEventListener("click", this.handleNavigateToRecord);
    }
}