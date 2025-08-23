resource "aws_codebuild_project" "terraform_build"{
     name          = "terraform-build-jayamaran"
     description   = "CodeBuild project to run Terraform"
     build_timeout = 30 
     service_role  = aws_iam_role.codebuild_role.arn


source {
    type            = "GITHUB"
    location        = "https://github.com/Sedin-Jayamaran/Terraform-Buggy-Jai"
    buildspec       = "buildspec.yml"
    git_clone_depth = 1
  }

artifacts {
    type = "NO_ARTIFACTS"
  }


environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0" 
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true # required if you build Docker images
    image_pull_credentials_type = "CODEBUILD"
  }


logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/terraform-build"
      stream_name = "terraform-build-log"
    }
  }

}