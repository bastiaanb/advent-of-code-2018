image: Dockerfile
	docker build --tag bastiaanb/whitespace .

%.ws: %.wst
	 tr 'TS' '\t ' < $< > $@

run: star1xebia.ws image
	docker run -i --rm -v $$(pwd)/star1xebia.ws:/app.ws --entrypoint whitespace bastiaanb/whitespace /app.ws < input.txt
