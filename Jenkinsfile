#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        // stage("Create an EKS Cluster") {
        //     steps {
        //         script {
        //             dir('terraform') {
        //                 sh """
        //                     terraform init
        //                     terraform apply -auto-approve
        //                 """
        //             }
        //         }
        //     }
        // }
        // stage("Deploy to EKS") {
        //     steps {
        //         script {
        //             dir('kubernetes') {
        //                 sh """
        //                     aws eks update-kubeconfig --name my-cluster
        //                     kubectl apply -f app.yaml
        //                 """
        //             }
        //         }
        //     }
        // }
        stage("Destroy Infrastructure (Cleanup)") {
            steps {
                input(
                    id: 'DestroyConfirmation',
                    message: 'Are you sure you want to destroy the EKS cluster?',
                    ok: 'Yes, Destroy Now'
                )
                script {
                    dir('terraform') {
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
    }
}