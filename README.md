# xMessenger (Administration utility)

This project is part of <b>xMessenger</b> application ecosystem. Hosted on Force.com platform; facilitates 
administration and data management activities.

### Keywords

`salesforce`, `heroku_external_objects`, `lightning_components`, `sfdx`, `travis`, `heroku`, `apex`, `javascript`, `rest-api`

### Built With

* [WebStorm](https://www.jetbrains.com/webstorm/) - Integrated IDE.
* [Salesforce CRM](https://www.salesforce.com/) - Worlds #1 CRM system.
* [TravisCI](https://travis-ci.com/) - CI and CD web utility.
* [Heroku](https://www.heroku.com/) - Cloud platform that lets companies build, deliver, monitor and scale apps.
* [VivifyScrum](https://app.vivifyscrum.com/) - Issue tracking product which allows bug tracking and agile project management.

### Versioning

For the versions available, see the [tags on this repository](https://github.com/awesomeandrey/xmessenger-admin/tags).

### Features

<hr/>

##### Live Chat

Considerations:

* Live Chat (LC) metadata components cannot be deployed to scratch orgs;
* `Embedded Service Deployments (ESD)` or `Snap-Ins` cannot be deployed;
* LC requires Salesforce `Site` registered/activated for hosting `ESD` scripts;
* Individual users should be added to proper configurations (`Queue`, `Chat Configuration`);
* `Service Presence Status` values should be added to respective permission set <u>manually</u>. 

### Authors

* **Andrii Melnichuk** - *Initial work* - [awesomeandrey](https://github.com/awesomeandrey)