container('ubuntu') {
    sh """
    pwd
    apt update && apt install -y wget tar
    wget http://apachemirror.wuchna.com/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz
    tar -xvf spark-2.4.5-bin-hadoop2.7.tgz
    """
}
container('docker') {
    dir('spark-2.4.5-bin-hadoop2.7') {
        sh """
        apk update
        apk upgrade
        apk add bash
        ./bin/docker-image-tool.sh -r "gcr.io/aiops-224805" -t 2.4.5 build
        docker push gcr.io/aiops-224805/spark-py:2.4.5
        """
    }
}
