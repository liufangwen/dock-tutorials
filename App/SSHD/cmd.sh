 docker build -t eg_sshd .
$ docker run -d -P --name test_sshd eg_sshd
$ docker port test_sshd 22
$ docker container stop test_sshd
$ docker container rm test_sshd
$ docker image rm eg_sshd
