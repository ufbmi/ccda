ALTER TABLE `lu_options`
CHANGE `parameter` `parameter` enum('display','width','height','rows','cols','max','min','headers','isOpen','isDisabled','video_src','autoplay','loop','aspectRatio','resetAvailable','show_logic','scored_section','audio_src','controls','preload','volume','required') COLLATE 'latin1_swedish_ci' NOT NULL AFTER `id`;
