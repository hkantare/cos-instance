provider "ibm" {
  ibmcloud_api_key      = "${var.ibmcloud_api_key}"
  //iaas_classic_username = "${var.iaas_classic_username}"
  //iaas_classic_api_key  = "${var.iaas_classic_api_key}"
}
variable "ibmcloud_api_key" {
}

data "ibm_resource_group" "group" {
  name = "default"
}

resource "ibm_resource_instance" "instance" {
  name              = "test"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = "${data.ibm_resource_group.group.id}"
  tags = ["t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9", "t10"]
}

resource "ibm_resource_key" "resourceKey" {
  name = "testkey"
  role = "Writer"
  resource_instance_id = "${ibm_resource_instance.instance.id}"
  parameters = {
   "HMAC" = true
  }
}
data "ibm_resource_key" "keydata" {
depends_on = ["ibm_resource_key.resourceKey"] 
name = "testkey"
 resource_instance_id = "${ibm_resource_instance.instance.id}"
}

/*resource "ibm_cos_bucket" "bucket" {
  bucket_name           = "testmy"
  resource_instance_id  = "${ibm_resource_instance.instance.id}"
  cross_region_location = "eu"
  storage_class         = "standard"
}*/
