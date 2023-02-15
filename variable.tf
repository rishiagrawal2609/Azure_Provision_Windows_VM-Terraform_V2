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

