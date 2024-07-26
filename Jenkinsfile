pipeline {
    agent any
    
    environment {
        // DOCKER_CREDENTIALS_ID = 'iddockerhub' // ID ваших учетных данных Docker Hub в Jenkins
        // DOCKER_IMAGE_NAME = 'kuleckiu/wordpressprod' // Замените на ваше имя пользователя и имя образа
        // DOCKER_COMPOSE_FILE = 'docker-compose.prod.yml'
        PRIVATE_KEY_ID = 'rsaaprivatedoplom'
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
                    // sshagent(['${PRIVATE_KEY}']) {
                    sh 'chmod 600 rsaa'
                    sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventories/inventory ansible/playbook.yaml'
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