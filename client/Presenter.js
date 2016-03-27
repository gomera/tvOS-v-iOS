var Presenter = {
	makeDocument: function(resource) {
		if (!Presenter.parser) {
			Presenter.parser = new DOMParser();
		}
		var doc = Presenter.parser.parseFromString(resource, "application/xml");
		return doc;
	},

	modalDialogPresenter: function(xml) {
		navigationDocument.presentModal(xml);
	},

	pushDocument: function(xml) {
		navigationDocument.pushDocument(xml);
	},

	load: function(event) {
  		var self = this,
  		ele = event.target,
      	videoURL = ele.getAttribute("videoURL")
      	
	  	if(videoURL) {
	
			var player = MoviePlayer.playerWithVideoURL(videoURL);
			player.play();

			// Originalmente la idea era extraer el link streameable usando el parser nativo de Youtube y usar el player 
			// que trae TVJS, pero no soporta el tipo de video. Otra buena razon para tener en cuenta esta tecnica para
			// hacer bridge entre JS y Native
			/*
			myplayer.fetchStreamURLWithCallback(function(streamURL) {
				var player = new Player();
				var playlist = new Playlist();
				var mediaItem = new MediaItem("video", streamURL);
				player.playlist = playlist;
				player.playlist.push(mediaItem);
				player.present();
			});
			*/
	  	}
	},
}