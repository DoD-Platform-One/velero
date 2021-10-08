# Scheduled Backup 

The schedule operation allows you to back up your data at recurring intervals. The first backup is performed when the schedule is first created, and subsequent backups happen at the schedule’s specified interval. These intervals are specified by a Cron expression.  Any number of schedules can be enabled in either YAML or using the cli. 

Scheduled backups are saved with the name <SCHEDULE NAME>-<TIMESTAMP>, where <TIMESTAMP> is formatted as YYYYMMDDhhmmss.

### **Command line schedule**
The simplest way to create a scheduled backup is by the command line. Below is a few commands run from the velero client.

### **See all options**
`velero create schedule --help`

 Some examples from the help menu are:

### **Create a backup every 6 hours**
`velero create schedule <SCHEDULE NAME>--schedule="0 */6 * * *"`



### **Create a daily backup of the web namespace**

`velero create schedule <SCHEDULE NAME>--schedule="@every 24h" --include-namespaces web`



###  **Create a weekly backup, each living for 90 days (2160 hours)**

The TTL flag allows the user to specify the backup retention period with the value specified in hours, minutes and seconds in the form --ttl 24h0m0s. If not specified, the default TTL value is 30 days.

`velero create schedule <SCHEDULE NAME>--schedule="@every 168h" --ttl 2160h0m0s`


To restore from a schedule you can use this command

`velero restore create myrestore --from-schedule myschedule`

 (restores the latest successful backup from myschedule)


To get a list of scheduled backups use

`velero describe schedule mydailybackup`



### **Adding a schedule to the BigBang helm chart**
``` yaml
schedules:
  mybackup:
    disabled: false
    labels:
      myenv: foo
    annotations:
      myenv: foo
    schedule: "0 0 * * *"
    useOwnerReferencesInBackup: true
    template:
      ttl: "240h"
      includedNamespaces:
      - foo

