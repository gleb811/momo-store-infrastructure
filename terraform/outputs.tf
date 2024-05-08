# output "cluster_master_endpoint" {
#     value = yandex_kubernetes_cluster.momo_cluster.master.*.external_v4_endpoint
# }

output "cluster_id" {
  value = yandex_kubernetes_cluster.momo_cluster.id
}