resource "aws_iam_instance_profile" "instance_profile" {
  name = local.name_prefix
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = local.name_prefix
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}


# Define an IAM policy
resource "aws_iam_policy" "iam_policy" {
  name        = local.name_prefix
  description = "Policy for ${local.name_prefix}"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "${var.s3_bucket_arn}/*",
          "${var.s3_bucket_arn}"
          ]
          },
      {
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        "Resource": "${var.kms_arn}"
      }

    ]
  }
  EOF
}
