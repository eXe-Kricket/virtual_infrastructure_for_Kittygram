data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2404-lts"
}

resource "yandex_vpc_network" "kittygram" {
  name = "kittygram-network"
}

resource "yandex_vpc_subnet" "kittygram" {
  name           = "kittygram-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.kittygram.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

resource "yandex_vpc_security_group" "kittygram" {
  name       = "kittygram-security-group"
  network_id = yandex_vpc_network.kittygram.id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Kittygram gateway HTTP"
    protocol       = "TCP"
    port           = var.gateway_port
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Allow all outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "kittygram" {
  name        = var.vm_name
  platform_id = var.platform_id
  zone        = var.yc_zone

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.disk_size
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.kittygram.id]
  }

  metadata = {
    user-data = file("${path.module}/cloud-init.yaml")
    ssh-keys  = "ubuntu:${var.ssh_public_key}"
  }
}

resource "yandex_storage_bucket" "kittygram" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = var.app_bucket_name
}
