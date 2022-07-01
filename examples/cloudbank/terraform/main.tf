
module distributed-builds-private-jenkins {
  source = "./jenkins-module"
  compartment_id     = var.compartment_ocid
  jenkins_password   = var.jenkins_password
  region             = var.region
  unique_agent_names = ["agent1"] # Only one agent
}