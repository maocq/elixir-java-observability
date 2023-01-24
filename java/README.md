# Java Observability

```shell
# Service

#200
curl http://localhost:8080/api/usecase/account?status=200

#500
http://localhost:8080/api/usecase/account?status=500

#Latency
http://localhost:8080/api/usecase/latency?delay=0

# Error
http://localhost:8080/api/usecase/latency?delay=error
```
