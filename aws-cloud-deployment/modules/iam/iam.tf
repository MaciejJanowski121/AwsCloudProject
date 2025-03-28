#  IAM-Rolle für EC2 mit Zugriff auf S3, SSM, Secrets Manager und CloudWatch Logs
resource "aws_iam_role" "ec2_role" {
  name = "EC2FullRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

#  Eigene Policy – Leserechte auf S3-Bucket
resource "aws_iam_policy" "s3_readonly_policy" {
  name        = "S3ReadOnlyAccess"
  description = "EC2 darf Objekte aus dem S3-Bucket lesen"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:GetObject", "s3:ListBucket"]
      Resource = [
        "arn:aws:s3:::spring-bucket-maciej123",
        "arn:aws:s3:::spring-bucket-maciej123/*"
      ]
    }]
  })
}

#  Eigene Policy – Berechtigungen für AWS SSM
resource "aws_iam_policy" "ssm_policy" {
  name        = "SSMManagedInstanceCore"
  description = "Erlaubt EC2 die Verwendung von AWS SSM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:UpdateInstanceInformation",
          "ssm:ListInstanceAssociations",
          "ssm:GetCommandInvocation",
          "ssm:SendCommand",
          "ssm:DescribeInstanceInformation",
          "ssm:StartSession",
          "ssm:DescribeSessions",
          "ssm:TerminateSession",
          "ssm:GetConnectionStatus"
        ]
        Resource = "*"
      }
    ]
  })
}

#  Eigene Policy – Zugriff auf Secrets Manager
resource "aws_iam_policy" "secrets_access_policy" {
  name        = "SecretsManagerAccess"
  description = "Erlaubt EC2 das Auslesen von Secrets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["secretsmanager:GetSecretValue"]
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

#  Eigene Policy – CloudWatch Logs Zugriff
resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = "CloudWatchLogsAccess"
  description = "Erlaubt EC2 das Schreiben in CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# 📎 Policy-Attachments (eigene Policies)
resource "aws_iam_role_policy_attachment" "ec2_s3_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_readonly_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_secrets_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.secrets_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}

# 📎 AWS Managed Policy – SSM Session Manager
resource "aws_iam_role_policy_attachment" "ec2_ssm_managed_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#  Instance Profile für EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}