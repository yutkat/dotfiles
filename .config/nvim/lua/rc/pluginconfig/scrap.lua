local scrap = require("scrap")

local patterns = {
	{ "mx{,s}", "matri{x,ces}" },
}

local expanded = scrap.expand_many(patterns)
-- - mx => matrix
-- - Mx => Matrix
-- - mxs => matrices
-- - Mxs => Matrices

scrap.many_local_abbreviations(expanded)
