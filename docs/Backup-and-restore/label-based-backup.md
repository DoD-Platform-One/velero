# **Label Based backup and restore**

In this example we'll backup by label, and restore that same label. The example will the Velero CLI but can also be done with YAML and helm. The preferred option is to create these custom resources in and apply in the cluster. Examples are shown in the examples folder

 First you'll apply an appropriate label to all your elements of the application in YAML config or kubectl commands.



See the kubernetes [documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) on labels and selectors, below.


This assumes you have a properly configured storage location that Velero will use. You can check this using: 

`velero backup-location get`

The result should say phase:Available, if it doesn't you'll need to refer to documentation to configure you're particular storage.

This next command does a backup in the namespace of myapplicationlabel and uses a backup configuration of mybackupstoragelocation.

`velero backup create mybackup --selector application=myapplicationlabel --storage-location mybackupstoragelocation`

The storage-location is default if left blank. You can check the status of the backup, using the command

`velero backup describe mybackup` 

Pay particular attention to the "Phase" as  it will give you a progressive status of the backup.



### Restore by application label 

In this example we'll restore the application we just backed up to a new empty cluster you have already setup.

The new cluster **MUST** be exactly the same version of Kubernetes, Velero, and Helm with the same configuration as the backup cluster.

Velero should already be installed in the new cluster pointing to the same backup location as the backed up cluster. 


You should be able to see the backup you wish to restore by running this command in the context of the new cluster

`velero backup get`


To restore all the resources associated with the application selector myapplicationlabel. 

This will restore all pods, services, secrets, persistent volumes, etc.. that you have associated with the label selector.

`velero restore create myrestore  --from-backup mynamespace20210927163457 --selector application=myapplicationlabel`

You will be able to see the progress of the restore once it has been successfully queued with this command

`velero restore describe myrestore`  



Note: To troubleshoot a restore use the logs from this command and this help [page](https://velero.io/docs/v1.6/debugging-restores/) from the Velero docs. 

`velero restore logs myrestore`
