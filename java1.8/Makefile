NAME=serenedocker:java1.8


build: 
	docker build --no-cache --rm=true -t $(NAME) .


shell:
	docker run --rm -it $(NAME) bash


run: 
	docker run --rm -t $(NAME)
