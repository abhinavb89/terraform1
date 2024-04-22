###create the vnet need to be attached with your rg
resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name 
  address_space       = ["10.0.0.0/16"]
  

  tags = {
    environment = "Production"
  }
}
###inside the vnet we want to create a subnet
##two mapping need to be done one is with resource group the other one is with vnet

resource "azurerm_subnet" "mysubnet" {
    
  name                 = "my-subnet"
  #we are creating a subnet this subnet need to be part of rg
  resource_group_name  = azurerm_resource_group.myrg.name 
  #the subnet also is part of vnet
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]

  
}
##the public ip
resource "azurerm_public_ip" "mypublicip" {
  name  = "mypublicip"
   location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name 
  allocation_method = "Static" #or dynamic
}

#the network interface
resource "azurerm_network_interface" "myvmnic" {
  name = "vmnic"
    location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name 

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.mysubnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id 
  }
}