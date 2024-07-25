pipeline {
    agent any
    // triggers {
    //     pollSCM('* * * * *')
    // }
    environment {
        DOCKER_CREDENTIALS_ID = 'iddockerhub' // ID ваших учетных данных Docker Hub в Jenkins
        DOCKER_IMAGE_NAME = 'kuleckiu/wordpressprod' // Замените на ваше имя пользователя и имя образа
        DOCKER_COMPOSE_FILE = 'docker-compose.prod.yml'
        PRIVATE_KEY = 'rsaaprivatedoplom'
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонируем репозиторий
                git credentialsId: '1e3ace67-f6bd-462f-90b8-c7fe272007ac',  url: 'git@github.com:Kuleckiu/doploma.git', branch: 'main'
                
            }
        }
        stage('Create private file')
            steps {
                script {
                    sh "echo '$PRIVATE_KEY' > rsaa"
                    sh 'chmod 600 rsaa'
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
                    // sshagent(['${PRIVATE_KEY}']) {
                    // sh 'chmod 600 rsaa'
                    sh 'ansible-playbook -i ansible/inventories/inventory ansible/playbook.yaml'
                }
                }
            // }
        }     

        // stage('Check for changes') {
        //     steps {
        //         script {
        //             // Получаем список изменённых файлов
        //             def changedFiles = sh(script: 'git diff --name-only HEAD~1 HEAD', returnStdout: true).trim().split('\n')

        //             // Проверяем изменённые файлы и выполняем соответствующие команды
        //             if (changedFiles.any { it.endsWith('.yml') || it.endsWith('.yaml') }) {
        //                 echo 'Ansible files changed. Running Ansible...'
        //                 sh 'ansible-playbook your_playbook.yml'
        //             } else if (changedFiles.any { it.endsWith('.tf') }) {
        //                 echo 'Terraform files changed. Running Terraform...'
        //                 sh 'terraform apply -auto-approve'
        //             } 
        //             // else if (changedFiles.any { it.endsWith('.') }) {
        //             //     echo 'Terraform files changed. Running Terraform...'
        //             //     sh 'terraform apply -auto-approve'
        //             // }
        //              else {
        //                 echo 'No relevant changes detected.'
        //             }
        //         }
        //     }
        // }
    }
}