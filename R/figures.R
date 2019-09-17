######################
# AUXILLIARY FUNCTIONS
######################
generatePngs  <-  function (originFileName) {
    noExt  <-  tools::file_path_sans_ext(originFileName)
    system(paste0('sips -s formatOptions best -s format png ', originFileName, ' --out ', noExt, '.png'))
}

toPdf <- function (expr, filename, ...) {
    toDev(expr, pdf, filename, onefile = FALSE, ...)
}

toDev <- function (expr, dev, filename, ..., verbose = TRUE) {
    if (verbose) {
        cat(sprintf('Creating %s\n', filename))
    }
    dev(filename, ...)
    on.exit(dev.off())
    eval.parent(substitute(expr))
}

readAndTrimPng  <-  function (picPath) {
    pngFile  <-  png::readPNG(picPath)
    trimPngBlanks(pngFile)
}

trimPngBlanks  <-  function (pngMatrix) {
    pngMatrix[!apply(pngMatrix[, , 1], 1, function (x)all(x == 1)), !apply(pngMatrix[, , 1], 2, function (x)all(x == 1)), ]
}

changePngColour  <-  function (pngObject, col, ...) {
    # change colour
    # currently works for RGBa only
    rgbVals  <-  col2rgb(col, ...) / 255
    for(i in 1:3) {
        pngObject[, , i]  <-  rgbVals[i]
    }
    pngObject
}

annotation_custom2  <-  function (grob, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf, data) {
	layer(data = data, stat = StatIdentity, position = PositionIdentity, geom = ggplot2:::GeomCustomAnn, inherit.aes = TRUE, params = list(grob = grob, xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax))
}

makeManagementPanel  <-  function (dest, ...) {
    ggplot2::ggsave(dest, managementPanel(...), device = 'pdf', width = 9, height = 4.5, units = 'in', onefile = FALSE)
}

managementPanel  <-  function (bestModel, data, picPath, ...) {
	assign('data', data, env = .GlobalEnv)
	effs             <-  as.data.frame(effects::allEffects(bestModel))[[1]]
	effs$Management  <-  paste0('Management ', effs$Management)
	remove('data', envir = .GlobalEnv)

	ggplot2::ggplot(data = effs, aes(x = Year, y = fit)) +
		geom_line(aes(colour = Management), size = 1.5) +
		annotation_custom2(grid::rasterGrob(changePngColour(readAndTrimPng(picPath), col = 'grey30'), interpolate = TRUE), xmin = 2000, xmax = 2004, data = effs[effs$Management == 'Management a', ], ...) + 
		geom_ribbon(aes(ymin = lower, ymax = upper, fill = Management), alpha = 0.3) + 
		scale_color_manual(values = c('tomato', 'dodgerblue2')) + 
		scale_fill_manual(values = c('tomato', 'dodgerblue2')) + 	
		facet_grid(~ Management) +
		theme_bw() + 
		theme(legend.position = 'none') +
		ylab('Abundance')
}

makeManagementPanelBrms  <-  function (dest, ...) {
    ggplot2::ggsave(dest, managementPanelBrms(...), device = 'pdf', width = 9, height = 4.5, units = 'in', onefile = FALSE)
}

managementPanelBrms  <-  function (brmsModel, picPath, ...) {
	brmsEffs  <-  brms::marginal_effects(brmsModel)[['Year:Management']]
	brmsEffs$Management  <-  paste0('Management ', brmsEffs$Management)

	ggplot2::ggplot(data = brmsEffs, aes(x = Year, y = estimate__)) +
		geom_line(aes(colour = Management), size = 1.5) +
		scale_y_continuous(trans = 'log10') + 
		annotation_custom2(grid::rasterGrob(changePngColour(readAndTrimPng(picPath), col = 'grey30'), interpolate = TRUE), xmin = 2000, xmax = 2004, data = brmsEffs[brmsEffs$Management == 'Management a', ], ...) + 
		geom_ribbon(aes(ymin = lower__, ymax = upper__, fill = Management), alpha = 0.3) + 
		scale_color_manual(values = c('tomato', 'dodgerblue2')) + 
		scale_fill_manual(values = c('tomato', 'dodgerblue2')) + 	
		facet_grid(~ Management) +
		theme_bw() + 
		theme(legend.position = 'none') +
		ylab('Abundance')
}

makePosteriorDists  <-  function (dest, ...) {
    toPdf(posteriorDists(...), dest, width = 7, height = 7)
}

posteriorDists  <-  function (brmsModel, ...) {
	plot(brmsModel, ...)
}

makeExploratoryHistograms  <-  function (dest, ...) {
    ggplot2::ggsave(dest, histograms(...), device = 'pdf', width = 7, height = 7, units = 'in', onefile = FALSE)
}

histograms  <-  function (data) {
	theme_set(theme_bw() +
	          theme(panel.grid = element_blank(),
	                axis.text = element_text(size = 11, colour = 'black'),
	                axis.title = element_text(size = 12, colour = 'black'),
	                strip.text = element_text(size = 11, colour = 'black'),
	                legend.position = 'bottom',
	                legend.text = element_text(size = 11, colour = 'black')
	                )
	          )

	data %>% gather(key = 'Species', value = 'Abundance', damsel:grouper) %>%
	  drop_na() %>%
	  ggplot(aes(x = Abundance, linetype = Region, colour = Region)) +
	  geom_freqpoly(alpha = 0.7, size = 0.8) +
	  scale_colour_brewer(palette = 'Spectral') +
	  scale_linetype_manual(values = c('dotted', 'dashed', 'solid', 'twodash')) +
	  facet_wrap( ~ Species, scales = 'free') +
	  ylab('Frequency') +
	  theme(legend.key.size = unit(2, 'line'),
	        legend.margin = margin(c(5, 5, 5, 0)),
	        legend.text = element_text(margin = margin(r = 10, unit = 'pt')),
	        panel.spacing = unit(1.5, 'lines'),
	        plot.margin = unit(c(0.2, 0.5, 0, 0.2), 'cm'))
}

makeExploratoryTrends  <-  function (dest, ...) {
    ggplot2::ggsave(dest, temporalTrends(...), device = 'pdf', width = 7, height = 7, units = 'in', onefile = FALSE)
}

temporalTrends  <-  function (data) {

	theme_set(theme_bw() +
	            theme(panel.grid = element_blank(),
	                  axis.text = element_text(size = 11, colour = 'black'),
	                  axis.title = element_text(size = 12, colour = 'black'),
	                  strip.text = element_text(size = 11, colour = 'black'),
	                  legend.position = 'bottom',
	                  legend.text = element_text(size = 11, colour = 'black')
	            )
	)

	data %>% gather(key = 'Species', value = 'Abundance', damsel:grouper) %>%
	  drop_na() %>%
	  ggplot(aes(x = Year, y = Abundance, colour = Management)) +
	  geom_point(alpha = 0.6) +
	  facet_grid(Region ~ Species, scales = 'free_y') +
	  scale_colour_manual(values = c('tomato', 'dodgerblue2'))
}
