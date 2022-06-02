How to setup a VM by using Libvirt + Terraform 
=================================

# Download the scripts 
Download all the configuration files and put them in the same directory .  
- "terraform init " : Init the backend of terraform  
- " terraform plan" : Review all changes and settings that will be setup when running file TF  
- " terraform apply " : Start the setup  
- " terraform destroy" : Remove all setup setttings .  
  
In the included files , I have 3 file that you need to pay attetion on : 
- Main.tf : The main file that will setup img , instance .
- Cloud_init.cfg: Use to create commoninit.iso . This iso is used to setup the environment of OS. Mostly i will only setup password for users in here . 
- network_config.cfg : Basic network setup in instance .


# Manually create a image qcow2

For some reason , the plugin we using have a error when auto download cloud image online and format it to qcow2 . So this is how we handle ( work around) .
We just have to download cloud image file manually and conver them into qcow2 with qcow2-img .  
For example , if we want to install an instance with Ubuntu 22.04 cloud image OS .  
 * Download image to current working directory 
     > `wget https://cloud-images.ubuntu.com/releases/jammy/release-20220513/ubuntu-22.04-server-cloudimg-amd64.img -O Ubuntu2004-cloud.img`
 * Formati it into qcow2 image
     > `qemu-img ./Ubuntu2004-cloud.img size 10G`

# Run the script 

> 'terraform init'  
> 'terraform plan '  
> ' sudo terraform apply -auto-approve'  
> ' sudo terraform destroy -auto-approve'  

# How to change the OS that you want to install ? 
 
Replace in the source link by the one you want   

https://cloud.centos.org/centos/7/images/  
https://download.opensuse.org/repositories/Cloud:/Images:/Leap_42.3/images/  
https://cloud-images.ubuntu.com/  
