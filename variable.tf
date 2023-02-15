# variables - all parameters needs to be added

variable "vnName" {
  description = "Name of the VM"
  default = "Windows-Vm"
  type = string
}

variable "VmCount" {
  description = "Number of VM that needs to be Provisoned"
  default = "1"
  type = string
}

variable "location" {
  description = "Location where the VM should be Provisoned"
  default = "East US"
  type = string
  validation {
    condition = contains([ "WEST US", "WEST CENTRAL US", "EAST US", "EAST US 2", "AUSTRALIA EAST", "AUSTRALIA SOUTHEAST", "BRAZIL SOUTH", "CANADA CENTRAL", "CANADA EAST", "CENTRAL INDIA", "CENTRAL US", "EAST ASIA", "FRANCE CENTRAL", "JAPAN EAST ", "JAPAN WEST", "KOREA CENTRAL", "KOREA SOUTH", "NORTH CENTRAL US", "NORTH EUROPE", "SOUTH CENTRAL US", "SOUTH INDIA", "SOUTHEAST ASIA", "SOUTH AFRICA NORTH", "UK SOUTH", "UK WEST", "WEST CENTRAL US", "WEST EUROPE", "WEST INDIA" ], var.location )
    error_message = "Please Give the correct location"
  }
}

variable "Require_availability_set" {
  description = "Availabilityset is needed for new virtual machine to host yes/no. Availabilityset - We recommended that two or more VMs are created within an availability set to provide for a highly available application and to meet the 99.95% Azure SLA"
  default = null
  type = string
  validation {
    condition = contains(["yes","no"],var.Require_availability_set)
    error_message = "Provide 'yes' or 'no' only"
  }
}

variable "Use_existing_avilabilityset" {
  description = "select yes/no to host virtual machine to host in existing availabilityset."
  default = null
  type = string
  nullable = true
  validation {
    condition = contains(["yes","no"],var.Use_existing_avilabilityset)
    error_message = "Please provide only 'yes' or 'no'"
  }
}
variable "Existing_availabilitysetname" {
  description = "select name of the existing availabilityset where the vms will be placed."
  type = string
  #source = "availabilityset.list_availabilityset"
  nullable = true
  default = null
}
variable "availability_setname" {
  type = string
  default = null
  description = "Name of the Availability Set where the VM will be placed"
  nullable = true
}
variable "FaultDomainCount" {
  description = "No.of fault domains."
  default =  null
  type = number
  nullable = true
  validation {
    condition = var.FaultDomainCount > 1 && var.FaultDomainCount < 3
    error_message = "Should be between 1 and 3 (int)"
  }
}

variable "UpdateDomainCount" {
  description = "No.of update domains."
  default =  null
  type = number
  nullable = true
  validation {
    condition = var.UpdateDomainCount > 1 && var.UpdateDomainCount < 3
    error_message = "Should be between 1 and 3 (int)"
  }
}

variable "imageSku" {
  description = "select the Windows image sku"
  default = "2016-Datacenter"
  type = string
  validation {
    condition = contains(["2008-R2-SP1","2008-R2-SP1-smalldisk","2008-R2-SP1-zhcn","2012-Datacenter","2012-datacenter-gensecond","2012-Datacenter-smalldisk","2012-Datacenter-zhcn","2012-R2-Datacenter","2012-r2-datacenter-gensecond","2012-R2-Datacenter-smalldisk","2012-R2-Datacenter-zhcn","2016-Datacenter","2016-datacenter-gensecond","2016-Datacenter-Server-Core","2016-Datacenter-Server-Core-smalldisk","2016-Datacenter-smalldisk","2016-Datacenter-with-Containers","2016-Datacenter-zhcn","2019-Datacenter","2019-Datacenter-Core","2019-Datacenter-Core-smalldisk","2019-Datacenter-Core-with-Containers","2019-Datacenter-Core-with-Containers-smalldisk","2019-datacenter-gensecond","2019-Datacenter-smalldisk","2019-Datacenter-with-Containers","2019-Datacenter-with-Containers-smalldisk","2019-Datacenter-zhcn","2022-datacenter","2022-datacenter-g2","2022-datacenter-azure-edition"],var.imageSku)
    error_message = "Please give the vaild ImageSKU ID"
  }
}

variable "vmSize" {
  description = "Mention the size of the VM"
  type = string
  default = "B1s"
  #source = "instance_size.list_instance_size"
}

variable "adminUsername" {
  type = string
  default = "adminuser"
  description = "User Name for Admin for perticular VM"
}

variable "adminPassword" {
  type = string
  description = "Admin password for the VM"
  sensitive = true
}

variable "useManagedDisk" {
  type = string
  default = null
  description = "managed disks are block-level storage volumes that are managed by Azure.Unmanaged disk consists of three data services: Blob storage, File storage, and Queue storage. In an unmanaged disk, you manage the storage accounts that you use to store the virtual hard disk (VHD) files that correspond to your VM disks. VHD files are stored as page blobs in Azure storage accounts."
  nullable = true
  validation {
    condition = contains(["yes","no"],var.useManagedDisk)
    error_message = "give only 'yes' or 'no'"
  }
}

variable "disk_type" {
  type = string
  default = "Standard_LRS"
  description = "disk type which would be attached with both os managed disks and data disks"
  validation {
    condition = contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS"], var.disk_type)
    error_message = "Select only from 'Standard_LRS', 'StandardSSD_LRS', 'Premium_LRS'"
  }
}

variable "use_existingStorageAccount" {
  type = string
  default = null
  nullable = true
  description = "select yes/no to Host new virtual machine into existingStgAccount."
  validation {
    condition = contains(["yes", "no"],var.use_existingStorageAccount)
    error_message = "Provide only yes/no"
  }
}

variable "ExistingStorageAccountName" {
  type = string
  default = null
  nullable = true
  # source = "storage_account.list_storage_account"
  description = "Select Existing Storage Account"
}

variable "storageAccountName" {
  type = string
  default = null
  nullable = true
  description = "New Storage Account Name"
}

variable "StorageAccountType" {
  type = string
  default = null
  nullable = true
  validation {
    condition = contains([ "Premium_LRS", "Standard_GRS", "Standard_GZRS", "Standard_LRS", "Standard_ZRS"],var.StorageAccountType)
    error_message = "Select the Correct Account Type"
  }
}

variable "bootDignostics" {
  type = string
  default = null
  nullable = true
  description = "Boot diagnostics is a debugging feature for Azure virtual machines (VM) that allows diagnosis of VM boot failures. Boot diagnostics enables a user to observe the state of their VM as it is booting up by collecting serial log information and screenshots.Note:-Boot Diagnostics supports Standard_GRS,Standard_LRS storage account types."
  validation {
    condition = contains(["true","false"],var.bootDignostics)
    error_message = "Put only True or False"
  }
}

variable "RequireDataDisk" {
  type = string
  default = null
  nullable = true
  description = "select yes/no to create and attach data disks to new virtual machine."
  validation {
    condition = contains(["yes", "no"],var.RequireDataDisk)
    error_message = "Give only 'yes' or 'no'"
  }
}

variable "numDataDisk" {
  type = number
  default = null
  nullable = true
  description = "This parameter allows the user to select the number of disks they want"
  validation {
    condition = var.numDataDisk > 1 && var.numDataDisk < 64
    error_message = "The Value should be between {1,64}"
  }
}

variable "sizeOfDataDiskinGB" {
  type = number
  default = null
  nullable = true
  description = "Mention Size of the data disk"
  validation {
    condition = var.sizeOfDataDiskinGB > 16 && var.sizeOfDataDiskinGB < 4096
    error_message = "Allowed size is between {16,4096} GB"
  }
}

variable "use_ExistingVnet" {
  type = string
  default = null
  nullable = true
  description = "select yes/no to use existing virtual network and subnet for new virtual machine."
  validation {
    condition = contains(["yes", "no"],var.use_ExistingVnet)
    error_message = "please give only 'yes' or 'no'"
  }
}

variable "ExistingSubnetName" {
  type = string
  default = null
  nullable = true
  #source = virtual_network.list_all_subnet
  description = "Specify the subnet within the virtual network where you would like to deploy this virtual machine. Do not select the gateway subnet in the virtual network. Also, do not select the dedicated subnet in which your managed domain is deployed."
}

variable "virtualNetworkName" {
  type = string
  default = null
  nullable = true
  description = "Name of new virtual network"
}

variable "addressPrefixes" {
  type = string
  default = null
  nullable = true
  description = "Mention virtual network addressprefixes range.Ex:-10.0.0.0/16"
}

variable "subnetName" {
  type = string
  default = null
  description = "Name of the  virtualnetwork subnet."
  nullable = true
}

variable "subnetRange" {
  type = string
  default = null
  nullable = true
  description = "Mention virtual network subnet range.Ex:-10.0.0.0/24"
}

variable "RequirePublicIp" {
  type = string
  nullable = true
  description = "yes/no for assigning public IP or not"
  validation {
    condition = contains(["yes","no"],var.RequirePublicIp)
    error_message = "give only 'yes' or 'no'"
  }
}

variable "publicIpAddressName" {
  type = string
  nullable = true
  description = "Name of new public IP resource"
  default = null
}

variable "RequireNSG" {
  
}