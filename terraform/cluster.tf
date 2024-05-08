resource "yandex_kubernetes_cluster" "momo_cluster" {
  name        = var.cluster_name
  description = "K8s cluster for Momo application"

  network_id = yandex_vpc_network.momo_network.id

  master {
    version   = "1.22"
    public_ip = true
    zonal {
      zone      = var.zone
      subnet_id = yandex_vpc_subnet.momo_subnet.id
    }
  }

  service_account_id      = yandex_iam_service_account.momo_cluster_sa.id
  node_service_account_id = yandex_iam_service_account.momo_node_group_sa.id

  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_resourcemanager_folder_iam_member.images_puller
  ]
}


resource "yandex_kubernetes_node_group" "momo_node_group" {
  cluster_id  = yandex_kubernetes_cluster.momo_cluster.id
  name        = "${var.cluster_name}-node-group"
  description = "K8s cluster node group for Momo application"

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  instance_template {
    platform_id = var.instance.platform_id

    network_interface {
      nat        = true
      subnet_ids = [yandex_vpc_subnet.momo_subnet.id]
    }

    resources {
      cores  = var.instance.cores
      memory = var.instance.memory
    }

    boot_disk {
      type = var.instance.disk_type
      size = var.instance.disk_size
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    auto_scale {
      initial = var.autoscale.initial
      min     = var.autoscale.min
      max     = var.autoscale.max
    }
  }

}