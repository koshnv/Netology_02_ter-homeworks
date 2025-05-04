#Создаёт виртуальную сеть
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#Создаёт подсеть внутри сети develop
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vms_net.web.subnet_IP
}

#Создаёт вторую подсеть для базы данных
resource "yandex_vpc_subnet" "develop_db" {
  name           = local.develop_db #"${var.vpc_name}-db"
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vms_net.db.subnet_IP # ["10.0.2.0/24"] Замечание
}

# Запрашивает информацию о последней доступной версии образа из семейсва Ubuntu
data "yandex_compute_image" "Ubuntu" {
  family = var.vm_web_image_family
}

# Дублирование кода. Aлогично предыдущему блоку, запрашивает образ Ubuntu для базы данных из семейства
#data "yandex_compute_image" "Ubuntu_db" {
#  family = var.vm_db_image_family
#}

#Создаёт виртуальную машину (ВМ) для веб-сервера
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name  # Заменил на локальную переменную
  platform_id = var.vm_web_platform_id
  resources {
#    cores         = var.vm_web_cores
#    memory        = var.vm_web_memory
#    core_fraction = var.vm_web_core_fraction
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.Ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_net.web.nat # true
  }

#  metadata = var.metadata
   metadata = local.full_metadata
#  metadata = {
#    serial-port-enable = 1
#    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
#  }


}

# Создаёт ВМ для базы данных
resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name  # Заменил на локальную переменную
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone
  resources {
#    cores         = var.vm_db_cores
#    memory        = var.vm_db_memory
#    core_fraction = var.vm_db_core_fraction
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  boot_disk {
    initialize_params {
      #image_id = data.yandex_compute_image.Ubuntu_db.image_id #Дублирование кода
      image_id = data.yandex_compute_image.Ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.vms_net.db.nat
  }

#  metadata = var.metadata
   metadata = local.full_metadata
#  metadata = {
#    serial-port-enable = 1
#    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
#  }
}