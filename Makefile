.PHONY: build
build:
	sudo docker compose --env-file envs/cpu.env build airs

.PHONY: run
run:
	sudo docker compose --env-file envs/cpu.env up airs

.PHONY: rund
rund:
	sudo docker compose --env-file envs/cpu.env up -d airs

.PHONY: stop
stop:
	sudo docker compose --env-file envs/cpu.env down

.PHONY: shell
shell:
	sudo docker compose --env-file envs/cpu.env exec -it airs /bin/bash

.PHONY: build/gpu
build/gpu:
	sudo docker compose --env-file envs/gpu.env build airs

.PHONY: shell/gpu
shell/gpu:
	sudo docker compose -f docker-compose-gpu.yml --env-file envs/gpu.env run --rm airs /bin/bash

.PHONY: run/gpu
run/gpu:
	sudo docker compose -f docker-compose-gpu.yml --env-file envs/gpu.env up airs

.PHONY: rund/gpu
rund/gpu:
	sudo docker compose -f docker-compose-gpu.yml --env-file envs/gpu.env up -d airs