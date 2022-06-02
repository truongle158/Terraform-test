# Innotech
- "terraform init " : Init the backend of terraform
- " terraform plan" : Review all changes and settings that will be setup when running file TF
- " terraform apply " : Start the setup 
- " terraform destroy" : Remove all setup setttings .

In the included files , I have 3 file that you need to pay attetion on : 
- Main.tf : The main file that will setup img , instance .
- Cloud_init.cfg: Use to create commoninit.iso . This iso is used to setup the environment of OS. Mostly i will only setup password for users in here . 
- network_config.cfg : Basic network setup in instance .


How to change the OS that you want to install ? 
You just have to replace the ubuntu link in this like by the one you choose in file main.tf 

resource "libvirt_volume" "distro-qcow2" {  
  name   = "distro-qcow2"  
  pool   = "truongln"  
  source = "https://cloud-images.ubuntu.com/releases/jammy/release-20220513/ubuntu-22.04-server-cloudimg-amd64.img"  
  format = "qcow2"  
}  
  
#Replace in the source link by the one you want   

https://cloud.centos.org/centos/7/images/  
https://download.opensuse.org/repositories/Cloud:/Images:/Leap_42.3/images/  
https://cloud-images.ubuntu.com/  
