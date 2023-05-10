# Configure the VMware vSphere Provider
provider "vsphere" {
    vsphere_server = "${var.vsphere_vcenter}"
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    allow_unverified_ssl = true
}

# Build CentOS
resource "vsphere_virtual_machine" "dev_cloudx_com_tr_deployment" {
    name   = "dev.cloudx.com.tr_deployment"
    vcpu   = 2
    memory = 8192
    domain = "dev.cloudx.com.tr"
    datacenter = "${var.vsphere_datacenter}"
    cluster = "${var.vsphere_cluster}"

    # Define the Networking settings for the VM
    network_interface {
        label = "VM Network"
        ipv4_gateway = "185.184.24.1"
        ipv4_address = "185.184.24.215"
        ipv4_prefix_length = "24"
    }

    dns_servers = ["10.0.1.10", "8.8.8.8"]

    # Define the Disks and resources. The first disk should include the template.
    disk {
        template = "CentOS-7-x86_64.vmware"
        datastore = "vsanDatastore"
        type ="thin"
    }

    # Define Time Zone
    time_zone = "America/Chicago"
}