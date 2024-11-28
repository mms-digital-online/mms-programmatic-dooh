compose_config = -f docker-compose.yaml
override_config = docker-compose.override.yaml

infrastructure = postgres redis
apps = worker-default

ifneq ("$(wildcard $(override_config))","")
	compose_config += -f ${override_config}
endif

infr:
	docker-compose ${compose_config} up -d ${infrastructure}

up:
	docker-compose ${compose_config} up -d ${apps}

down:
	docker-compose ${compose_config} down

stop:
	docker-compose ${compose_config} stop

rebuild:
	docker-compose ${compose_config} up -d --build ${apps}

build:
	docker-compose ${compose_config} build --no-cache ${apps}

restart:
	docker-compose ${compose_config} restart ${apps}
