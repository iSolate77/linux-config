local util = require("lspconfig.util")

return {
	root_dir = function(filepath)
		return (
			util.root_pattern("hie.yaml", "stack.yaml", "cabal.project")(filepath)
			or util.root_pattern("*.cabal", "package.yaml")(filepath)
		)
	end,
	settings = {
		haskell = {
			formattingProvider = "ormolu",
		},
	},
}
