#!/bin/bash
# Add lifecycle
lifecycle=""
# Add org
org=""
DATE=$(date +%m_%d_%y)

STEP1() {
touch /root/patching_reports/patching_report_$DATE.txt && echo NEW REPORT: $DATE > /root/patching_reports/patching_report_$DATE.txt
return
}

STEP2() {
hammer -c /root/bin/configs/hammer_no_timeout.yml content-host list --lifecycle-environment $lifecycle --organization $org | awk '{print $3}' | grep -v NAME > prod_list.txt
return
}

STEP3() {
for x in `cat prod_list.txt`; do hammer -c /root/bin/configs/hammer_no_timeout.yml host errata list --host $x >> /root/patching_reports/patching_report_$DATE.txt && echo $x >> /root/patching_reports/patching_report_$DATE.txt; done
return
}

# Main script that generates reports based on previous functions
