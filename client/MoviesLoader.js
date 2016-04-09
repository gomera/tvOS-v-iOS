function MoviesLoader(baseurl) {
	this.BASEURL = baseurl;
}

var createMoviesTemplate = function(movies) {

	var movieItemsTemplate = "";
	for(var i=0; i < movies.length; i++) {
		movie = movies[i];
		movieItemsTemplate += createMovieItemTemplate(movie);
	}

	var template = `<?xml version="1.0" encoding="UTF-8" ?>
		<document>
			<listTemplate>
				<banner> 
		      		<title>Mi Collection de Videos</title>
		    	</banner>
		    	<list> 
		    		<header>
		    			<title>Favoritos</title>
		    		</header>
		      		<section>
		      			${movieItemsTemplate}
		      		</section>
		    	</list>
		  	</listTemplate>
		</document>`

	return template
}

var createMovieItemTemplate = function(movie) {
	var movieItemTemplate = `<listItemLockup videoURL='${movie.video}'>
		<title>${movie.title}</title>
		<relatedContent>
			<lockup>
				<img src='${movie.thumbnail}' width='857' height='482' />
				<description>${movie.summary}</description>
			</lockup>
		</relatedContent>
	</listItemLockup>`

	return movieItemTemplate
}

// En una applicaion mas real, usariamos algo como Express y alguna herramienta de parsing como Jade o EJS
// Aca como solo tenemos un solo template, preferi hacer eso en vez de agregar mas dependencias.
MoviesLoader.prototype.load = function(callback) {
	var self = this;
	var templateXHR = new XMLHttpRequest();
	templateXHR.responseType = "json";
	templateXHR.addEventListener("load", function() {
		var movies = templateXHR.response.movies;
		var template = createMoviesTemplate(movies);
		callback(template);
	}, false);
	templateXHR.open("GET", `${this.BASEURL}/movies.js`, true);
	templateXHR.send();
}