pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
    }
    environment {
        // Define AWS credentials as environment variables
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        REGION                = 'us-east-1'
    }

    stages {
        stage('Checkout') {
           when {
                expression { params.ACTION == 'apply' }
            }
             steps {
                // Check out the repository with Terraform code
                git branch: 'main', 
                    url: 'https://github.com/Pravesh2201/project_es.git'
            }
        }

    stage('Terraform Init') {
        when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir('terraform_es') {

                    sh '''
                        terraform init \
                        -backend-config="bucket=elasticsearch-tool" \
                        -backend-config="key=terraform/state" \
                        -backend-config="region=${REGION}" \
                        -backend-config="dynamodb_table=terraform-lock-table"
                    '''
                }
               
            }
        }

    stage('Terraform Plan') {
        when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                   dir('terraform_es') {
                       sh 'terraform plan -lock=false'
                   }

            }
        }

      stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir('terraform_es') {
                    sh '''
                        terraform apply -auto-approve -lock=false
                        terraform output -raw IP_Public_Bastion > bastion_ip.txt
                        terraform output -raw IP_elasticsearch > elasticsearch_ip.txt
                    '''
                }
            }
        }
        

      stage('Approval for Destroy') {
         when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                // Prompt for approval before destroying resources
                input "Do you want to Terraform Destroy?"
            }
        }

      stage('Terraform Destroy') {
                when {
                    expression { params.ACTION == 'destroy' }
                }
                steps {
                       dir('terraform_es') {
                           sh 'terraform destroy -auto-approve'
                       }
                }
                post {
                    always {
                    // Cleanup workspace after the build destroy
                        cleanWs()
                    }
                }
            }

            
      stage('Ansible Playbook Execution') {
                when {
                    expression { params.ACTION == 'apply' }
                }
                steps {
                    dir('project_es') {


                        script {
                            // Reading the correct file path for bastion and elasticsearch IPs
                            def bastionIp = readFile('../terraform_es/bastion_ip.txt').trim()
                            def elasticsearchIp = readFile('../terraform_es/elasticsearch_ip.txt').trim()
                            // Dynamically creating the inventory file with the correct IP addresses
                            writeFile file: 'inventory', text: """
                            
                            [bastion]
                            
                            ${bastionIp} ansible_ssh_private_key_file=/var/lib/jenkins/AWS.pem ansible_user=ubuntu
                            [elasticsearch]
                            ${elasticsearchIp} ansible_ssh_private_key_file=/var/lib/jenkins/AWS.pem ansible_user=ubuntu
                            scp -i /var/lib/jenkins/AWS.pem /var/lib/jenkins/AWS.pem ubuntu@${bastionIp}:/home/ubuntu/
                            ssh -i /var/lib/jenkins/AWS.pem ubuntu@${bastionIp} 'sudo chmod 400 /home/ubuntu/AWS.pem'
                            """
                        }
                        
                        sh '''
                        ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory /var/lib/jenkins/workspace/project_es/playbook.yml
                        '''
                    }
                }
            }
    }
}

                    
