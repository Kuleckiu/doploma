pipeline {
    agent any
    // triggers {
    //     pollSCM('* * * * *')
    // }
    environment {
        DOCKER_CREDENTIALS_ID = 'iddockerhub' // ID ваших учетных данных Docker Hub в Jenkins
        DOCKER_IMAGE_NAME = 'kuleckiu/wordpressprod' // Замените на ваше имя пользователя и имя образа
        DOCKER_COMPOSE_FILE = 'docker-compose.prod.yml'
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонируем репозиторий
                git credentialsId: '1e3ace67-f6bd-462f-90b8-c7fe272007ac',  url: 'git@github.com:Kuleckiu/doploma.git', branch: 'main'
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
                    sh 'ansible-playbook -i ansible/inventories/inventory ansible/playbook.yaml --ssh-common-args='-o StrictHostKeyChecking=no''
                    }
            }
        }
        // stage('build wordpress image') {
        //     steps {
        //         sh "docker compose -f ${DOCKER_COMPOSE_FILE} build"
        //     }
        // }
        // stage('Login to Docker Hub') {
        //     steps {
        //         script {
        //             // Вход в Docker Hub
        //             docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        
        //             }
        //         }
        //     }
        // }

        // stage('Push Docker Image') {
        //     steps {
        //         script {
        //             // Пушим образ в Docker Hub
        //             sh "docker tag wordpressdi:latest ${DOCKER_IMAGE_NAME}:latest" // Замените your-service-name на имя вашего сервиса
        //             sh "docker push ${DOCKER_IMAGE_NAME}:latest"
        //         }
        //     }
        // }

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