[![License: CC BY-IGO 3.0](https://licensebuttons.net/l/by-nc/3.0/igo/80x15.png)](https://creativecommons.org/licenses/by/3.0/igo)

<!--badges-->
![CI Build](https://img.shields.io/github/actions/workflow/status/WorldHealthOrganization/smart-pcmt/ghbuild.yml)  
   
![QA errors](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2FWorldHealthOrganization.github.io%2Fsmart-pcmt%2Fqa.json&query=%24.errs&logoColor=red&label=QA%20errors&color=yellow)
![QA warnings](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2FWorldHealthOrganization.github.io%2Fsmart-pcmt%2Fqa.json&query=%24.warnings&logoColor=orange&label=QA%20warnings&color=yellow)
![QA hints](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2FWorldHealthOrganization.github.io%2Fsmart-pcmt%2Fqa.json&query=%24.hints&logoColor=yellow&label=QA%20hints&color=yellow)
<!--/badges-->

# WHO SMART GUIDELINES - SMART Product Catalogue

CI-Build: [https://worldhealthorganization.github.io/smart-pcmt](https://worldhealthorganization.github.io/smart-pcmt)

This is an ImplementationGuide for the Product Catalogue requirements for the SMART Guidelines and ICVP

## Changes and feedback
  
Feedback and issues can be submitted via the upstream [issues](https://github.com/WorldHealthOrganization/smart-pcmt/issues) page, and will be incorporated into subsequent releases.

## Harness

This fork (litlfred/smart-pcmt) is a harnessed instance of smart-base, in the shape of smart-immunizations: `index.config.json` mounts the platform layers and `smart-pcmt.json` declares the instance. It is downstream of [dth-pc](https://github.com/litlfred/dth-pc), whose product catalogue concepts its logical models realise. See [AGENTS.md](AGENTS.md).
 
