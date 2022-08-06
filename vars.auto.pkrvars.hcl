vsphere_server   = "vcsa.kazmi.lab"
vsphere_user     = "Administrator@vsphere.local"
vsphere_password = "Badfish509"
datacenter       = "LabDatacenter"
cluster          = "Lab Cluster"
datastore        = "iSCSI-Datastore"
network_name     = "vData"
builder_ipv4     = "10.0.0.50"
ssh_username     = "root"
ssh_password     = "Goodfish509"
# EXPORT "vsphere_password" & "ssh_password" like below example:
# Also don't forget to put an extra space before the word "export" in below example, so the password won't be saved in bash history.
#-------------EXAMPLE------------------#
# export TF_VAR_vsphere_password="YOUR-TOP-SECRET-PASSWORD"
# export TF_VAR_ssh_password="YOUR-TOP-SECRET-PASSWORD"