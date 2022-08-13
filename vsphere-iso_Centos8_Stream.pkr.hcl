source "vsphere-iso" "centos8stream" {
  # Builder configuration, responsible for VM provisioning.
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_user
  password            = var.vsphere_password
  datacenter          = var.datacenter
  cluster             = var.cluster
  convert_to_template = true
  insecure_connection = true

  vm_name       = "Centos8Cloud"
  guest_os_type = "centos8_64Guest"

  ssh_username = var.ssh_username
  ssh_password = var.ssh_password

  CPUs            = 1
  RAM             = 1024
  RAM_reserve_all = false

  disk_controller_type = ["pvscsi"]
  datastore            = var.datastore
  storage {
    disk_size             = 16384
    disk_thin_provisioned = true
  }

  iso_paths = ["[iSCSI-Datastore] IscsISO/CentOS/CentOS-Stream-8-x86_64-latest-dvd1.iso"]

  network_adapters {
    network      = var.network_name
    network_card = "vmxnet3"
  }

  # CentOS OS parameters
  boot_order            = "disk,cdrom,floppy"
  boot_wait             = "10s"

  http_ip = var.builder_ipv4
  http_directory    = "scripts"
  boot_command      = [
    "<up><wait><tab><wait> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
  ]
}

build {
  sources = [
    "source.vsphere-iso.centos8stream"
  ]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E sh -eux '{{.Path}}'" # This runs the scripts with sudo
    scripts = [
        "scripts/yum_update.sh",
        "scripts/cleanup.sh"
    ]
  }
}
