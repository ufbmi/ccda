ALTER TABLE `lu_options`
CHANGE `parameter` `parameter` enum('display','width','height','rows','cols','max','min','headers','isOpen','isDisabled','src','autoplay','loop','aspectRatio','resetAvailable','show_logic','scored_section','audio_src') COLLATE 'latin1_swedish_ci' NOT NULL AFTER `id`;
