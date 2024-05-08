# Service account for master node
resource "yandex_iam_service_account" "momo_cluster_sa" {
  name        = "${var.cluster_name}-sa"
  description = "Service account for k8s master node of cluster for momo-app"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.momo_cluster_sa.id}"

  depends_on = [
    yandex_iam_service_account.momo_cluster_sa
  ]
}

# Service account for node group
resource "yandex_iam_service_account" "momo_node_group_sa" {
  name        = "${var.cluster_name}-node-group-sa"
  description = "Service account for node group of cluster for momo-app"
}

resource "yandex_resourcemanager_folder_iam_member" "images_puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.momo_node_group_sa.id}"

  depends_on = [
    yandex_iam_service_account.momo_node_group_sa
  ]

}