all:  build

build:
	docker build -t ryangraham/postfix-mailgun .

run:
	docker run --name postfix-mailgun -e "MG_USER=fred@flintstone.com" -e "MG_PASS=bedrock" -p 25:25 -d ryangraham/postfix-mailgun

rm:
	docker stop postfix-mailgun && docker rm postfix-mailgun

attach:
	docker exec -it postfix-mailgun bash
