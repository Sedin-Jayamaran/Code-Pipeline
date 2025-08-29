module "service" {
    source = "./service"
    td_arn = module.taskdefinition.task_definition_arn
    
}
module "taskdefinition" {
    source = "./taskdefinition"
    image = var.image 

}