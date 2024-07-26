pipeline {
    agent any
    
    environment {
        PRIVATE_KEY_ID = 'rsaaprivatedoplom'
        JSON_FILE_ID_GCP = 'JsonForGcp'
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонируем репозиторий
                git credentialsId: '1e3ace67-f6bd-462f-90b8-c7fe272007ac',  url: 'git@github.com:Kuleckiu/doploma.git', branch: 'main'
                
            }
        }
        stage('Create private file') {
            steps {
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
                    // Получаем список изменённых файлов
                    def changedFiles = sh(script: 'git diff --name-only HEAD~1 HEAD', returnStdout: true).trim().split('\n')
                    env.CHANGED_FILES = changedFiles.join(' ')
                    echo "Изменённые файлы:\n${changedFiles.join('\n')}"
                    if (changedFiles.size() == 0) {
                        echo "Нет изменений с последней сборки."
                    } else {
                        echo "Изменения найдены: ${changedFiles.size()} файлов."
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Применение Terraform для создания инстанса
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
                    sh 'chmod 600 rsaa'
                    sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventories/inventory ansible/playbook.yaml'
                }
                }
        }
        stage('Check Service Availability') {
            steps {
                script {
                    sh 'python3 extract_and_curl.py'
                }
            }
        }
    }
}