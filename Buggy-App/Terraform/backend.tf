terraform {
  backend "s3" {
    bucket         = "jai-terra-bucket-1011"   
    key            = "ecs/jai_service.tfstate" 
    region         = "ap-south-1"             
    encrypt        = true
  }
}
