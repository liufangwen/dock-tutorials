docker build -t eg_postgresql .
docker run --rm -P --name pg_test eg_postgresql
docker run --rm -t -i --link pg_test:pg eg_postgresql bash

