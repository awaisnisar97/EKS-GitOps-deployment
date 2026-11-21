resource "helm_release" "example" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.14.0"

  set = [
  {
    name  = "clusterName"
    value = var.cluster_name
  }
]
}


