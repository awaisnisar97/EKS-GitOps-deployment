#Creating the iam role for EKS cluster 
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

#Attaching the AmazonEKSClusterPolicy to the EKS cluster role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#Creating the iam role for EKS worker nodes
resource "aws_iam_role" "eks_node_group_role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

#Attaching the AmazonEKSWorkerNodePolicy to the EKS node group role
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

#Attaching the AmazonEC2ContainerRegistryPullOnly to the EKS node group role
resource "aws_iam_role_policy_attachment" "eks_ecr_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

#Creating the iam role for EKS CNI
resource "aws_iam_role" "eks_cni_role" {
  name = "eks-cni-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })
}

#Attaching the AmazonEKS_CNI_Policy to the EKS CNI role
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_cni_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

#Creating the iam role for EKS Load Balancer Controller
resource "aws_iam_role" "load_balancer_controller_role" {
  name = "eks-load-balancer-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })
}

#Attaching the AmazonEKSLoadBalancerControllerPolicy to the EKS Load Balancer Controller role
resource "aws_iam_policy" "load_balancer_controller_policy" {
  name        = "eks-load-balancer-controller-policy"
  description = "Policy for the AWS Load Balancer Controller"
  policy      = file("${path.module}/policies/load_balancer_controller_policy.json")
}

#Attaching the load balancer controller policy to the load balancer controller role
resource "aws_iam_role_policy_attachment" "load_balancer_controller_policy_attachment" {
  role       = aws_iam_role.load_balancer_controller_role.name
  policy_arn = aws_iam_policy.load_balancer_controller_policy.arn
}

#Creating the iam role for EKS External DNS
resource "aws_iam_role" "external_dns_role" {
  name = "eks-external-dns-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })
}

#Creating the iam policy for EKS External DNS
resource "aws_iam_policy" "external_dns_policy" {
  name        = "eks-external-dns-policy"
  description = "Policy for the External DNS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["route53:ListHostedZones"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "route53:ListResourceRecordSets",
        ]
        Resource = "arn:aws:route53:::hostedzone/Z02915703VH7GHG3NWR0V"
      },
      {
        Effect   = "Allow"
        Action   = "route53:ChangeResourceRecordSets"
        Resource = "arn:aws:route53:::hostedzone/Z02915703VH7GHG3NWR0V"
        Condition = {
          "ForAllValues:StringEquals" : {
            "route53:ChangeResourceRecordSetsNormalizedRecordNames" = [
              "eks.awaiscloud.click",
              "a-eks.awaiscloud.click"
            ]
          }
        }
      }
    ]
  })
}

#Attaching the external dns policy to the external dns role
resource "aws_iam_role_policy_attachment" "external_dns_policy_attachment" {
  role       = aws_iam_role.external_dns_role.name
  policy_arn = aws_iam_policy.external_dns_policy.arn
}

#Creating the iam role for EKS cert-manager
resource "aws_iam_role" "cert_manager_role" {
  name = "eks-cert-manager-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })
}

#Creating the iam policy for EKS cert-manager
resource "aws_iam_policy" "cert_manager_policy" {
  name        = "eks-cert-manager-policy"
  description = "Policy for the cert-manager"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "route53:GetChange",
        "Resource" : "arn:aws:route53:::change/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : "arn:aws:route53:::hostedzone/Z02915703VH7GHG3NWR0V",
        "Condition" : {
          "ForAllValues:StringEquals" : {
            "route53:ChangeResourceRecordSetsRecordTypes" : ["TXT"]
            "route53:ChangeResourceRecordSetsNormalizedRecordNames" = [
              "_acme-challenge.eks.awaiscloud.click"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : "route53:ListHostedZonesByName",
        "Resource" : "*"
      }
    ]
    }
  )
}

#Attaching the cert-manager policy to the cert-manager role
resource "aws_iam_role_policy_attachment" "cert_manager_policy_attachment" {
  role       = aws_iam_role.cert_manager_role.name
  policy_arn = aws_iam_policy.cert_manager_policy.arn
}

