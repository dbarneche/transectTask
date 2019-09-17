####################
# GENERAL STAN SPECS
####################
rstan::rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

###################
# GENERAL FUNCTIONS
###################
readFile  <-  function (...) {
	read.csv(..., header = TRUE, stringsAsFactors = FALSE)
}

addColumns  <-  function (data) {
	data$Site2     <-  paste0(data$Site, data$Management) # each block has 4 sites, better for nesting
	data$baseline  <-  ifelse(data$Year <= 2003, 'yes', 'no') # whether management strategies were differentiated
	data
}

readAndModifyData  <-  function (...) {
	data  <-  readFile(...)
	addColumns(data)
}

# Bayesian
runBrmsDamselModel  <-  function (data) {
	brms::brm(damsel ~ baseline + Year * Management + (1 | Region/Block/Site2), data = data, family = zero_inflated_negbinomial(), chains = 3)
}

# TMB
runTMBModels  <-  function (data, response) {
	model  <-  eval(parse(text = sprintf('glmmTMB::glmmTMB(%s ~ baseline + Year * Management + (1 | Region/Block/Site2), data = data, ziformula = ~1, family = nbinom2)', response)))
	model_no_base  <-  eval(parse(text = sprintf('glmmTMB::glmmTMB(%s ~ Year * Management + (1 | Region/Block/Site2), data = data, ziformula = ~1, family = nbinom2)', response)))
	model_no_int  <-  eval(parse(text = sprintf('glmmTMB::glmmTMB(%s ~ baseline + Year + Management + (1 | Region/Block/Site2), data = data, ziformula = ~1, family = nbinom2)', response)))
	list('model' = model,
		 'model_no_base' = model_no_base,
		 'model_no_int' = model_no_int)
}

extractBestTMBModel  <-  function (modelList) {
	model          <-  modelList[['model']]
	model_no_base  <-  modelList[['model_no_base']]
	model_no_int   <-  modelList[['model_no_int']]
	out  <-  bbmle::AICtab(model, model_no_base, model_no_int)
	get(attr(out, 'row.names')[1])
}

logitTransformToProb  <-  function (zi) {
	# This transforms the linear predictor of zi into a probability applying a logit-link:
	# 1 / (1 + exp(-zi))
	1 / (1 + exp(-zi))
}
