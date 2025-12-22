name_rg = {
  rg1 = {
    name     = "pra007"
    location = "east us2"
    tags = {
      environment = "deployment"
      cost_center = "eric"
    }
  }
}

nw_virtual = {
  "vnet1" = {
    name                = "pra_vnet"
    location            = "east us2"
    resource_group_name = "pra007"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]

    subnet = {
      fe_subnet = {
        name             = "pra_fe_subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      be_subnet = {
        name             = "pra_be_subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
      firewall_subnet = {
        name             = "pra_firewall_subnet"
        address_prefixes = ["10.0.3.0/24"]
      }
    }
  }
}

pip_engress = {
  fe_pip = {
    name                = "pra_frontend_pip"
    location            = "east us2"
    resource_group_name = "pra007"
    allocation_method   = "Static"
    tags = {
      cost_center = "self"
      purpose     = "public"
    }
  }
  be_pip = {
    name                = "pra_backend_pip"
    location            = "east us2"
    resource_group_name = "pra007"
    allocation_method   = "Static"
  }
}

server_sql = {
  server = {
    name                         = "prasqlserver007"
    location                     = "east us2"
    resource_group_name          = "pra007"
    version                      = "12.0"
    administrator_login          = "pra_admin"
    administrator_login_password = "Pra@#2025"
    minimum_tls_version          = "1.2"

    azuread_administrator = {
      login_username = "lovelycodeing_gmail.com#EXT#@lovelycodeinggmail.onmicrosoft.com"
      object_id      = "20e31367-e391-4976-a405-60ba4c272bc6"
    }
    tags = {
      environment  = "dev"
      owner        = "pra_team"
      project      = "sql-praglobelization007"
      costcenter   = "CC-1023"
      businessunit = "finance"
    }
  }
}

sqldb = {
  dbsql = {
    name = "erp-sql"
    # server_id    = module.server_sql.server_ids["server"]
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
    sql_server   = "prasqlserver007"
    rg_name      = "pra007"

    tags = {
      environment         = "dev"
      owner               = "pra_team"
      project             = "sql-erpglobelization007"
      costcenter          = "CC-1023"
      businessunit        = "finance"
      created_by          = "terraform"
      data_classification = "confidential"
    }
  }
}


vms = {
  vm1 = {
    vm_name     = "erpfevm"
    nic_name    = "erpfe_nic"
    location    = "east us2"
    rg_name     = "pra007"
    vnet_name   = "pra_vnet"
    subnet_name = "pra__fe_subnet"
    kv_name     = "my-secreate02"
    # pip_name       = "frontend_pip"
    size           = "Standard_F2"
    admin_username = "vm-username"
    admin_password = "vm-password"
    # public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDtUmYaaoeA5581ehGFZ/u4OpuV6PIcQNZU1Wl6nCcsq7RKHKwWTDVBq8+wASOOP+xa6iFnhJYtJhcza3D4GBjYXlpan7++B2Qx65sBE6UsqldaTyMzxMtONpcmEdWV0BVblW0PGpXTmtyA0e6xg1IRnkCLHfLalumlU9KOPpB6DuXn2ouVfmqqFbJA521Mcn9DaNLqPnTV9nJwt8/FVC1OvpZzJ4yvuOOUixkfYm0An6aYRynep+tvrgAdFSvJmcWKLly/IL6tyX1r4oHDeC5buxlMK2QaSIli/Wgi30rhYgh+XuUV/ufjHfoRb8JkKpJ0VqHyKT+KmmQ1eZsXNfXyyWD0adscMEkn/u4qKCdhW85qPhQqGOPyf48BUOezd6vPxqja065AY0HyI9nOj05OdbNMPODav6usxtOmVuJAWQeSEcER9cnfvVzp1+2a4zeIwGsAd+JxWNcSnIYn2DvwK79KjQtGD75c0mrwCVV7oeHHzpIX1bfln3DPZbqd8DDseES6QrfegzOlHXFZXiIXjKRw5HyG2ykk9i5FqmXFOU5AFfegELf2qpU99qwKgNl7sVL4MDjj5co9qDQkN+UulGKcN6Qp7qAn7VXQNOfySL2rFfC9KFp+JhN4xuJG2h/Y+8KiC378tvjCwC4Oy2WZBKqKsnD/UABAPdcvMb9EXQ== kapil@LAPTOP-6KILMVK3"
    source_image_reference = {
      image1 = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
    os_disk = {
      disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }
    custom_data = "local"
  }

  vm2 = {
    vm_name     = "erpbevm"
    nic_name    = "erpbe_nic"
    location    = "east us2"
    rg_name     = "pra007"
    vnet_name   = "pra_vnet"
    subnet_name = "erp_be_subnet"
    kv_name     = "my-secreate02"
    # pip_name       = "backend_pip"
    size           = "Standard_F2"
    admin_username = "vm-username"
    admin_password = "vm-password"
    # public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDtUmYaaoeA5581ehGFZ/u4OpuV6PIcQNZU1Wl6nCcsq7RKHKwWTDVBq8+wASOOP+xa6iFnhJYtJhcza3D4GBjYXlpan7++B2Qx65sBE6UsqldaTyMzxMtONpcmEdWV0BVblW0PGpXTmtyA0e6xg1IRnkCLHfLalumlU9KOPpB6DuXn2ouVfmqqFbJA521Mcn9DaNLqPnTV9nJwt8/FVC1OvpZzJ4yvuOOUixkfYm0An6aYRynep+tvrgAdFSvJmcWKLly/IL6tyX1r4oHDeC5buxlMK2QaSIli/Wgi30rhYgh+XuUV/ufjHfoRb8JkKpJ0VqHyKT+KmmQ1eZsXNfXyyWD0adscMEkn/u4qKCdhW85qPhQqGOPyf48BUOezd6vPxqja065AY0HyI9nOj05OdbNMPODav6usxtOmVuJAWQeSEcER9cnfvVzp1+2a4zeIwGsAd+JxWNcSnIYn2DvwK79KjQtGD75c0mrwCVV7oeHHzpIX1bfln3DPZbqd8DDseES6QrfegzOlHXFZXiIXjKRw5HyG2ykk9i5FqmXFOU5AFfegELf2qpU99qwKgNl7sVL4MDjj5co9qDQkN+UulGKcN6Qp7qAn7VXQNOfySL2rFfC9KFp+JhN4xuJG2h/Y+8KiC378tvjCwC4Oy2WZBKqKsnD/UABAPdcvMb9EXQ== kapil@LAPTOP-6KILMVK3"
    source_image_reference = {
      image1 = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
    os_disk = {
      disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }
    custom_data = "local"
  }
}


vault_keys = {
  "keys" = {
    name                = "erpmy-secrete01"
    location            = "east us2"
    resource_group_name = "pra007"
    sku_name            = "standard"
  }
}

bastion_my = {
  bastion1 = {
    name        = "erp_bastion"
    location    = "east us2"
    rg_name     = "pra007"
    subnet_name = "AzureBastionSubnet"
    pip_name    = "backend_pip"
    vnet_name   = "pra_vnet"
  }
}
