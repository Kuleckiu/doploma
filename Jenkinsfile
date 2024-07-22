pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонируем репозиторий
                                    git url: 'git@github.com:Kuleckiu/doploma.git', branch: 'main'
            }
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