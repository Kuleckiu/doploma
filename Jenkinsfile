pipeline {
    agent any
    //specifying environmentsss variables
    environment {
        PRIVATE_KEY_ID = 'rsaaprivatedoplom'
        JSON_FILE_ID_GCP = 'JsonForGcp'
    }

    stages {
        stage('Checkout') {
            steps {
                // clone code
                git credentialsId: '1e3ace67-f6bd-462f-90b8-c7fe272007ac',  url: 'git@github.com:Kuleckiu/doploma.git', branch: 'main'
                
            }
        }
        stage('Create private file') {
            steps {
                // create private key file and .json file
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: PRIVATE_KEY_ID, keyFileVariable: 'PRIVATE_KEY_FILE')]) {
                        writeFile file: 'rsaa', text: readFile(PRIVATE_KEY_FILE)}
                    sh 'chmod 600 rsaa'
                }
                script {
                    withCredentials([file(credentialsId: JSON_FILE_ID_GCP, variable: 'JSON_FILE')]) {
                        writeFile file: 'new-poject-425116-b1de9f7edb20.json', text: readFile(JSON_FILE)}
                }
            }
        }
        stage('Check for changes') {
            steps {
                script {
                    // Getting list changes files
                    def changedFiles = sh(script: 'git diff --name-only HEAD~1 HEAD', returnStdout: true).trim().split('\n')
                    env.CHANGED_FILES = changedFiles.join(' ')
                    echo "changed files:\n${changedFiles.join('\n')}"
                    if (changedFiles.size() == 0) {
                        echo "Changes are empty."
                    } else {
                        echo "Changes have found: ${changedFiles.size()} files."
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Terraform up
                    sh 'pwd'
                    sh 'terraform init '
                    sh 'terraform plan'
                    sh 'terraform apply -auto-approve'
                    
                    }
            }
        }
        stage('Ansible') {
            steps {
                script {
                    //Ansible up
                    sh 'chmod 600 rsaa'
                    sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventories/inventory ansible/playbook.yaml'
                }
                }
        }
        stage('Check Service Availability') {
            steps {
                //healf check
                script {
                    sh 'python3 extract_and_curl.py'
                }
            }
        }
    }
}
