start-backend-servers: reverse-proxy s1 s2 s3
	./reverse-proxy s1 9991 & echo $$! > s1.pid
	./reverse-proxy s2 9992 & echo $$! > s2.pid
	./reverse-proxy s3 9993 & echo $$! > s3.pid

reverse-proxy : main.go
	go build -o $@ $^

s1:
	echo "Hello from server $@" > $@
s2:
	echo "Hello from server $@" > $@
s3:
	echo "Hello from server $@" > $@

stop-backend-servers:
	@kill $$(cat s1.pid) && echo "s1 stopped"
	@kill $$(cat s2.pid) && echo "s2 stopped"
	@kill $$(cat s3.pid) && echo "s3 stopped"

test : 
	while sleep 1; do curl http://localhost:8888; done
.PHONY: start-reverse-proxy start-backend-servers stop-backend-servers
